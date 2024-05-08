import * as net from "net";

import { OperationType, PacketControlSegment, PacketFromDevice, RawInitiateConnectionPacket, RawRegistrationPacket } from "./messages";
import { registerDevice } from "./registration";
import { areUint8ArraysEqual } from "./utils";
import DeviceManager from "../modules/device_management/model/DeviceManager";
import { randomFillSync } from "crypto";

export class DeviceConnectingServer {
	private serverInstance;
	private connectedDevices: ConnectedDeviceInfo[] = [];

	constructor() {
		this.serverInstance = new net.Server();
		this.serverInstance.on("connection", (socket) => {
			socket.on("data", async (data) => {
				const dataTyped = new Uint8Array(data);
				const packet = PacketFromDevice.decodePacket(dataTyped);
				switch (packet.controlSegment.operationType) {
					case OperationType.InitiateConnection: {
						if (await this.canCreateNewConnection(packet)) {
							socket.removeAllListeners(); // unbind old listeners - no need to init connections or register
							this.createNewConnection(socket, packet);
							console.log("Connected new device");
						} else {
							console.log("Device not allowed to connect");
							socket.end();
						}
						break;
					}
					case OperationType.RegisterDevice: {
						registerDevice(packet, socket);
						break;
					}
					default: {
						console.log("Device tried to perform operations despite not being connected");
						socket.end();
					}
				}
			})
		});
	}

	/*
	 * Communication session init flow:
	 * Device sends a APP_CONTROL_OP_INITCOMM with application_initcomm_section_t, session ID in control header is empty
	 * Server decodes that to a pair: OperationType::InitiateConnection and RawInitiateConnectionPacket
	 * Server verifies that the device is allowed to connect: is registered, the auth key is correct and isn't already connected
	 * Server generates session ID and fills that into the control header
	 * Server serializes and sends APP_CONTROL_OP_INITCOMM with application_initcomm_section_t to client
	 * Server remembers the session and authenticates further operations
	 */
	async canCreateNewConnection(packet: PacketFromDevice): Promise<boolean> {
		if (process.versions.bun) console.log("====DEBUG entered canCreateNewConnections====");

		const infoPacket = packet.messageContent as RawInitiateConnectionPacket; // needs to be called from a InitiateCommunication packet
		const deviceDatabase = await DeviceManager.GetDeviceByID(infoPacket.cameraID);

		if (!deviceDatabase) return false; // check if device ID exists
		if (process.versions.bun) console.log("====DEBUG device exists in db====");

		if (!areUint8ArraysEqual(deviceDatabase.get("auth_key") as Uint8Array, infoPacket.cameraAuthKey)) return false; // check if auth key is correct
		if (process.versions.bun) console.log("====DEBUG auth key correct====");

		if (this.connectedDevices.find(val => areUint8ArraysEqual(val.deviceID, infoPacket.cameraID))) return false; // check if device already connected
		if (process.versions.bun) console.log("====DEBUG device not already connected, allowed to connect====");

		return true;
	}

	async createNewConnection(socket: net.Socket, packet: PacketFromDevice) {
		const infoPacket = packet.messageContent as RawInitiateConnectionPacket; // needs to be called from a InitiateCommunication packet
		const sessionID = new Uint8Array(16);

		do {
			randomFillSync(sessionID);
		} while (this.connectedDevices.find(val => areUint8ArraysEqual(val.sessionID, sessionID)));

		packet.controlSegment.sessionID = sessionID;
		packet.controlSegment.isResponse = true;

		const deviceInfo = new ConnectedDeviceInfo(socket, infoPacket.cameraID, sessionID);
		this.connectedDevices.push(deviceInfo);

		socket.write(packet.serialize());

		socket.on("data", data => {
			const dataTyped = new Uint8Array(data);
			const packet = PacketFromDevice.decodePacket(dataTyped);
			switch (packet.controlSegment.operationType) {
				case OperationType.NoOperation: {
					deviceInfo.lastPacketReceived = Date.now();
				}
				default: {
					console.log("Unknown packet type");
					break;
				}
			}
		})
	}

	start(port: number) {
		this.serverInstance.listen(port);
	}
}

class ConnectedDeviceInfo {
	socket: net.Socket;
	deviceID: Uint8Array = new Uint8Array(16);
	sessionID: Uint8Array = new Uint8Array(16);
	lastPacketReceived: EpochTimeStamp = Date.now();

	constructor(socket: net.Socket, deviceID: Uint8Array, sessionID: Uint8Array) {
		this.socket = socket;
		this.deviceID = deviceID;
		this.sessionID = sessionID;
	}
}


// Mock mode, run with `bun run src/device_bridge/app.ts`
if (process.versions.bun) {
	console.log("======BUN START DEBUG======")
	const server = new DeviceConnectingServer();
	server.start(8090);
}