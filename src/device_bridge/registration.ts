import { Socket } from "net";
import { PacketFromDevice, RawRegistrationPacket } from "./messages";
import UserManager from "../modules/user_management/model/UserManager";
import { randomFillSync } from "crypto";
import DeviceManager from "../modules/device_management/model/DeviceManager";

/**
 * Registration module flow:
 * Stage one:
 * Client sends APP_CONTROL_OP_REGISTER with application_registration_section_t in packet. The camera ID field is empty
 * Server decodes that to a pair: MessageFromDevice::RegisterDevice and RegistrationPacket
 * If specified user ID does not exist, kill the socket
 * Server generates camera ID with at least one non-zero byte, saves it in a database, puts that into RegistrationPacket
 * Server encodes that from a pair: MessageFromDevice::RegisterDevice and RawRegistrationPacket
 * Server sends APP_CONTROL_OP_REGISTER with application_registration_section_t in packet to client
 * 
 * Stage two:
 * Client sends APP_CONTROL_OP_REGISTER with application_registration_section_t in packet.
 * Server decodes that to a pair: MessageFromDevice::RegisterDevice and RegistrationPacket
 * Server saves (hashed) camera auth key in database
 * Server echoes back the packet
 */

/**
 * 
 * @param data Packet to put auth key into.
 */
// data is pass by reference, no need to return
export async function registerDevice(data: PacketFromDevice, sock: Socket) {
	if (await UserManager.GetUserById(data.messageContent.userID)) {
		const device = await DeviceManager.GetDeviceByID(data.messageContent.cameraID);
		if (device) {
			// Registration stage two
			await device.update("auth_key", Buffer.from(data.messageContent.cameraAuthKey));
			data.controlSegment.isResponse = true;
			sock.write(data.serialize());
		} else {
			// Registration stage one
			const generatedDeviceID = new Uint8Array(16);
			do {
				randomFillSync(generatedDeviceID);
			} while (await DeviceManager.GetDeviceByID(generatedDeviceID));
			if (typeof await DeviceManager.CreateDevice(generatedDeviceID, data.messageContent.deviceMacAddress, data.messageContent.cameraAuthKey, data.messageContent.userID) == "string") {
				data.messageContent.cameraID = generatedDeviceID;
				data.controlSegment.isResponse = true;
				sock.write(data.serialize());
			}
		}
	} else {
		sock.end();
	}
}