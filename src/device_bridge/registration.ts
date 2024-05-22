import { Socket } from "net";
import { PacketData, RawRegistrationPacket } from "./messages";
import UserManager from "../modules/user_management/model/UserManager";
import { randomFillSync } from "crypto";
import DeviceManager from "../modules/device_management/model/DeviceManager";

/*
 * Registration module flow:
 * Stage one:
 * Client sends APP_CONTROL_OP_REGISTER with application_registration_section_t in packet. The camera ID field is empty
 * Server decodes that to a pair: OperationType::RegisterDevice and RegistrationPacket
 * If specified user ID does not exist, kill the socket
 * Server generates camera ID with at least one non-zero byte, saves it in a database, puts that into RegistrationPacket
 * Server encodes that from a pair: OperationType::RegisterDevice and RawRegistrationPacket
 * Server sends APP_CONTROL_OP_REGISTER with application_registration_section_t in packet to client
 * 
 * Stage two:
 * Client sends APP_CONTROL_OP_REGISTER with application_registration_section_t in packet.
 * Server decodes that to a pair: OperationType::RegisterDevice and RegistrationPacket
 * Server saves (hashed) camera auth key in database
 * Server echoes back the packet
 */

/**
 * 
 * @param data Packet to put auth key into.
 */
// data is pass by reference, no need to return
export async function registerDevice(data: PacketData, sock: Socket) {
	const registrationData = data.messageContent as RawRegistrationPacket;
	if (await UserManager.GetUserById(registrationData.userID)) {
		const device = await DeviceManager.GetDeviceByID(registrationData.cameraID);
		if (device) {
			if (device.get("registration_first_stage") == true) {
				// Registration stage two
				device.set("auth_key", Buffer.from(registrationData.cameraAuthKey));
				device.set("registration_first_stage", false);
				await device.save();
				data.controlSegment.isResponse = true;
				sock.write(data.serialize());
			} else {
				console.log("Device is trying to register itself again");
				sock.end();
			}
		} else {
			// Registration stage one
			const generatedDeviceID = new Uint8Array(16);
			do {
				randomFillSync(generatedDeviceID);
			} while (await DeviceManager.GetDeviceByID(generatedDeviceID));
			if (typeof await DeviceManager.CreateDevice(generatedDeviceID, registrationData.deviceMacAddress, registrationData.cameraAuthKey, registrationData.userID) != "string") {
				registrationData.cameraID = generatedDeviceID;
				data.controlSegment.isResponse = true;
				sock.write(data.serialize());
			}
		}
	} else {
		console.log("Device sent nonexistent user ID to register");
		sock.end();
	}
}