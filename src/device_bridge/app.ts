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


// Mock mode, run with `bun run src/device_bridge/app.ts`
if (process.versions.bun) {
	console.log("======BUN START DEBUG======")
	const server = new DeviceConnectingServer();
	server.start(/*8090*/3334);
}