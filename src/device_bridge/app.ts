import * as net from "net";

import { OperationType, PacketControlSegment, PacketFromDevice, RawRegistrationPacket } from "./messages";
import { registerDevice } from "./registration";

export class DeviceConnectingServer {
	private serverInstance;
	/**
	 *
	 */
	constructor() {
		this.serverInstance = new net.Server();
		this.serverInstance.on("connection", (socket) => {
			socket.on("data", (data) => {
				console.log(`Received ${data.length} bytes`);
				const packet = PacketFromDevice.decodePacket(data);
				console.log(`Decoded packet ${packet}`);
				packet.controlSegment.isResponse = true;
				switch (packet.controlSegment.operationType) {
					case OperationType.RegisterDevice: {
						registerDevice(packet.messageContent as RawRegistrationPacket);
						packet.controlSegment.isResponse = true;
						socket.write(packet.serialize());
					}
					default: {
						console.log("Unknown packet in server handler");
					}
				}
			})
		});
	}

	start(port: number) {
		this.serverInstance.listen(port);
	}
}

/**
 * Registration module rev-eng:
 * Client sends APP_CONTROL_OP_REGISTER with application_registration_section_t in packet.
 * Server decodes that to a pair: MessageFromDevice::RegisterDevice and RegistrationPacket
 * Server generates camera ID with at least one non-zero byte, saves it in a database, puts that into RegistrationPacket
 * Server encodes that from a pair: MessageFromDevice::RegisterDevice and RawRegistrationPacket
 * Server sends APP_CONTROL_OP_REGISTER with application_registration_section_t in packet to client
 */


// Mock mode, run with `bun run src/device_bridge/app.ts`
if (process.versions.bun) {
	console.log("======BUN START DEBUG======")
	const server = new DeviceConnectingServer();
	server.start(8090);
}