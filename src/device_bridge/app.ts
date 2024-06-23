import * as net from "net";

import { ImagePacket, NoDataPacket, OperationType, PacketControlSegment, PacketData, RawInitiateConnectionPacket, RawRegistrationPacket, RawUnregisterPacket } from "./messages";
import { registerDevice } from "./registration";
import { areUint8ArraysEqual } from "./utils";
import DeviceManager from "../modules/device_management/model/DeviceManager";
import { randomFillSync } from "crypto";
import { DeviceVideoManager } from "./videoManager";
import { createSocket } from "dgram";
import EventEmitter from "events";


export class DeviceConnectingServer extends EventEmitter {
	private serverInstance;
	private connectedDevices: ConnectedDevice[] = [];
	private videoFrameReceiver: any;

	constructor() {
		super();
		this.serverInstance = new net.Server();
		this.serverInstance.on("connection", (socket) => {
			socket.on("data", async (data) => {
				const dataTyped = new Uint8Array(data);
				const packet = PacketData.decodePacket(dataTyped);
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

		// // Initialize UDP socket
		// this.videoFrameReceiver = createSocket("udp4", message => {
		// 	//if (process.versions.bun) 
		// 	console.log(`### DEBUG UDP frame received of length ${message.length}`);

		// 	const dataTyped = new Uint8Array(message);

		// 	console.log(`### Creating ImagePacket from raw bytes...`)
		// 	const packet = ImagePacket.makeFromRawBytes(dataTyped);
		// 	console.log("### Seeking deviceInfo...")
		// 	const deviceInfo = this.connectedDevices.find(val => areUint8ArraysEqual(val.sessionID, packet.sessionID));

		// 	if (!deviceInfo) {
		// 		console.log("### Didn't find the device!");
		// 		throw new Error("### Received image packet for nonexistent session");
		// 	} else {
		// 		console.log("### Found the device, adding packet to videoManager for the device");
		// 		deviceInfo.videoManager.addPacket(packet);
		// 		console.log("### Done adding packet");
		// 	}
		// });

		// const udpPort = 3333;
		// this.videoFrameReceiver.bind(udpPort, () => {
		// 	console.log("### Listening for UDP packets on port ${udpPort}");
		// });

		

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
	async canCreateNewConnection(packet: PacketData): Promise<boolean> {
		if (process.versions.bun) console.log("====DEBUG entered canCreateNewConnections====");

		const infoPacket = packet.messageContent as RawInitiateConnectionPacket; // needs to be called from a InitiateCommunication packet
		const deviceDatabase = await DeviceManager.GetDeviceByID(infoPacket.cameraID);

		if (!deviceDatabase) { // check if device ID exists
			console.log("DEVICE ID DOES NOT EXIST");
			return false;
		}
		if (process.versions.bun) console.log("====DEBUG device exists in db====");

		if (!areUint8ArraysEqual(deviceDatabase.get("auth_key") as Uint8Array, infoPacket.cameraAuthKey)) {
			console.log("AUTH_KEY IS INCORRECT");
			return false; // check if auth key is correct
		}
		if (process.versions.bun) console.log("====DEBUG auth key correct====");

		// check if the device is already connected
		let connectedDevice = this.connectedDevices.find(val => areUint8ArraysEqual(val.deviceID, infoPacket.cameraID));
		if (connectedDevice) {
			console.log("WARNING: DEVICE ALREADY CONNECTED");
			//return false;
		}
		if (process.versions.bun) console.log("====DEBUG device not already connected, allowed to connect====");

		return true;
	}

	async createNewConnection(socket: net.Socket, packet: PacketData) {
		const infoPacket = packet.messageContent as RawInitiateConnectionPacket; // needs to be called from a InitiateCommunication packet
		const sessionID = new Uint8Array(16);

		do {
			randomFillSync(sessionID);
		} while (this.connectedDevices.find(val => areUint8ArraysEqual(val.sessionID, sessionID)));

		packet.controlSegment.sessionID = sessionID;
		packet.controlSegment.isResponse = true;

		const deviceInfo = new ConnectedDevice(socket, infoPacket.cameraID, sessionID);
		this.connectedDevices.push(deviceInfo);

		socket.write(packet.serialize());

		socket.on("data", data => {
			const dataTyped = new Uint8Array(data);
			const packet = PacketData.decodePacket(dataTyped);
			deviceInfo.lastPacketReceived = Date.now();
			switch (packet.controlSegment.operationType) {
				case OperationType.ForceUnregister: { // [TODO] WRONG - it should the other way around;
					const infoPacket = packet.messageContent as RawUnregisterPacket;
					console.log(`Received (somehow) unregister packet with succeeded value of ${infoPacket.succeeded[0]}`);
					break;
				}
				default: {
					console.log("Unknown packet type");
					break;
				}
			}
		});

		socket.on("close", () => {
			if (process.versions.bun) console.log("====DEBUG device disconnected====");
			this.connectedDevices = this.connectedDevices.filter(info => info != deviceInfo); // Ugly - remove the session after something disconnects
			deviceInfo.emit("disconnected", deviceInfo);
		});

		this.emit("deviceConnected", deviceInfo);
	}

	unregisterConnectedSession(sessionID: Uint8Array) {
		if (process.versions.bun) console.log("====DEBUG unregistering device====");

		if (sessionID.length != 16) throw new Error(`sessionID is of invalid length: (${sessionID.length})`);
		if (process.versions.bun) console.log("====DEBUG sessionID is of valid length====");

		const session = this.connectedDevices.find(val => areUint8ArraysEqual(val.sessionID, sessionID));
		if (!session) throw new Error("Specified sessionID does not exist");
		if (process.versions.bun) console.log("====DEBUG session found====");

		const requestControl = new PacketControlSegment();
		requestControl.operationType = OperationType.ForceUnregister;
		requestControl.sessionID = session.sessionID;
		requestControl.dataLength = new Uint32Array([RawUnregisterPacket.SIZE]);

		const request = new PacketData(requestControl, new RawUnregisterPacket(new Uint8Array([0])));

		session.socket.write(request.serialize());
		session.socket.end(); // Ignore any response - it doesn't matter
		if (process.versions.bun) console.log("====DEBUG session ended====");

		this.unregisterDeviceByID(session.deviceID);
	}

	/**
	 * Only removes device from database
	 * Do not use on connected devices
	 */
	unregisterDeviceByID(deviceID: Uint8Array) {
		if (deviceID.length != 16) throw new Error(`deviceID is of invalid length: (${deviceID.length})`);
		if (process.versions.bun) console.log("====DEBUG deviceID is of valid length====");

		const session = this.connectedDevices.find(val => areUint8ArraysEqual(val.deviceID, deviceID));
		if (session) throw new Error("Specified deviceID exists as a session, use `unregisterConnectedSession` instead");
		if (process.versions.bun) console.log("====DEBUG session does not exist====");
		
		DeviceManager.DeleteDeviceByID(deviceID);
		if (process.versions.bun) console.log("====DEBUG device removed from database====");
	}

	getSessionByDeviceID(deviceID: Uint8Array) {
		if (process.versions.bun) console.log("====DEBUG getSessionByDeviceID====");
		if (deviceID.length != 16) throw new Error(`deviceID is of invalid length: (${deviceID.length})`);
		return this.connectedDevices.find(val => areUint8ArraysEqual(val.deviceID, deviceID));
	}

	getSessionBySessionID(sessionID: Uint8Array) {
		if (process.versions.bun) console.log("====DEBUG getSessionBySessionID====");
		if (sessionID.length != 16) throw new Error(`sessionID is of invalid length: (${sessionID.length})`);
		return this.connectedDevices.find(val => areUint8ArraysEqual(val.sessionID, sessionID));
	}

	startTCP(port: number) { // THIS IS TCP
		this.serverInstance.listen(port, "0.0.0.0");
		//this.videoFrameReceiver.bind(port); // go away
	}

	startUDP(port: number) { // THIS IS UDP
		this.videoFrameReceiver = createSocket("udp6");

		this.videoFrameReceiver.on('error', (error: any) => {
			console.log('Error: ' + error);
  			this.videoFrameReceiver.close();
		});

		this.videoFrameReceiver.on('message', (msg: any, info: any) => {
			// console.log('!!! Received %d bytes from %s:%d\n',msg.length, info.address, info.port);

			// console.log(`### DEBUG UDP frame received of length ${msg.length}`);

			const dataTyped = new Uint8Array(msg);

			// console.log(`### Creating ImagePacket from raw bytes...`)
			const packet = ImagePacket.makeFromRawBytes(dataTyped);
			// console.log("### Seeking deviceInfo...")
			const deviceInfo = this.connectedDevices.find(val => areUint8ArraysEqual(val.sessionID, packet.sessionID));

			if (!deviceInfo) {
				console.log("### Didn't find the device!");
				throw new Error("### Received image packet for nonexistent session");
			} else {
				// console.log("### Found the device, adding packet to videoManager for the device");
				deviceInfo.videoManager.addPacket(packet);
				// console.log("### Done adding packet");
			}
		});

		this.on('listening', () => {
			var address = this.videoFrameReceiver.address();
			var port = address.port;
			var family = address.family;
			var ipaddr = address.address;
			console.log('UDP Server is listening at port' + port);
			console.log('UDP Server ip :' + ipaddr);
			console.log('UDP Server is IP4/IP6 : ' + family);
		});

		this.videoFrameReceiver.on('close', ()=>{
			console.log('UDP Server: socket has been closed !!! What to do now?');
		});

		this.videoFrameReceiver.bind(port);
	}
}

export class ConnectedDevice extends EventEmitter {
	socket: net.Socket;
	deviceID: Uint8Array = new Uint8Array(16);
	sessionID: Uint8Array = new Uint8Array(16);
	lastPacketReceived: EpochTimeStamp = Date.now();
	videoManager: DeviceVideoManager;

	constructor(socket: net.Socket, deviceID: Uint8Array, sessionID: Uint8Array) {
		super();
		this.socket = socket;
		this.deviceID = deviceID;
		this.sessionID = sessionID;
		this.videoManager = new DeviceVideoManager(sessionID);
	}

	beginStream() {
		const packetControl = new PacketControlSegment();
		packetControl.operationType = OperationType.BeginStream;
		packetControl.sessionID = this.sessionID;
		packetControl.dataLength = new Uint32Array([0]);
		const noDataSegment = new NoDataPacket();

		const fullPacket = new PacketData(packetControl, noDataSegment);

		this.socket.write(fullPacket.serialize());
	}

	endStream() {
		const packetControl = new PacketControlSegment();
		packetControl.operationType = OperationType.StopStream;
		packetControl.sessionID = this.sessionID;
		packetControl.dataLength = new Uint32Array([0]);
		const noDataSegment = new NoDataPacket();

		const fullPacket = new PacketData(packetControl, noDataSegment);

		this.socket.write(fullPacket.serialize());
	}
}


// // Mock mode, run with `bun run src/device_bridge/app.ts`
// if (process.versions.bun) {
// 	console.log("======BUN START DEBUG======")
// 	const server = new DeviceConnectingServer();
// 	server.start(8090); // [DEATH NOTE] magic numbers
// }
