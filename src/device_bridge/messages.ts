export enum OperationType {
	NoOperation,                         // APP_CONTROL_OP_NOP
	RegisterDevice,                      // APP_CONTROL_OP_REGISTER
	ForceUnregister,                     // APP_CONTROL_OP_UNREGISTER
	InitiateConnection,                  // APP_CONTROL_OP_INITCOMM
	SetConfig,                           // APP_CONTROL_OP_CAM_SET_CONFIG
	GetConfig,                           // APP_CONTROL_OP_CAM_GET_CONFIG
	GetCaps,                             // APP_CONTROL_OP_CAM_GET_CAPS
	BeginStream,                         // APP_CONTROL_OP_CAM_START_UNCONDITIONAL_STREAM
	StopStream,                          // APP_CONTROL_OP_CAM_STOP_UNCONDITIONAL_STREAM
	BeginMotionAnalysis,                 // APP_CONTROL_OP_ANALYSE
	StopMotionAnalysis,                  // APP_CONTROL_OP_CAM_STOP_ANALYSER_STREAM

	// I have no idea what this is
	ShutdownAnalyzerEnergySaving,        // APP_CONTROL_OP_ENERGY_SAVING_SHUTDOWN_ANALYSER
	WakeupAnalyzerEnergySaving,          // APP_CONTROL_OP_ENERY_SAVING_WAKEUP_ANALYSER
	ShutdownNetworkEnergySaving,         // APP_CONTROL_OP_ENERGY_SAVING_SHUTDOWN_NETIF
	ShutdownNetworkEnergySavingSchedule, // APP_CONTROL_OP_ENERGY_SAVING_SHUTDOWN_NETIF_SCHED
	SleepEnergySavingSchedule,           // APP_CONTROL_OP_ENERGY_SAVING_SCHED_SLEEP

	// currently won't be implemented
	__SendOTAUpdate,                     // APP_CONTROL_OP_OTA
	Reset,                               // APP_CONTROL_OP_SOFTWARE_DEVICE_RESET
	GetDeviceInfo,                       // APP_CONTROL_OP_GET_DEVICE_INFO
	Unknown,                             // APP_CONTROL_OP_UNKNOWN
}

// TODO update as other packets are implemented and used
type AllPossibleRawPackets = RawRegistrationPacket | RawInitiateConnectionPacket | RawUnregisterPacket | NoOperationPacket;

export class PacketData {
	controlSegment;
	messageContent;

	constructor(controlSeg: PacketControlSegment, rawData: AllPossibleRawPackets) {
		this.controlSegment = controlSeg;
		this.messageContent = rawData;
	}

	static decodePacket(rawData: Uint8Array): PacketData {
		if (rawData.length < RawPacketControlSegment.SIZE) throw new Error(`rawData passed to decodePacket was too short: ${rawData.length}`);
		const controlSegment = PacketControlSegment.makeFromRawBytes(rawData.slice(0, RawPacketControlSegment.SIZE));
		if (rawData.length != RawPacketControlSegment.SIZE + controlSegment.dataLength[0]) throw new Error(`rawData passed to decodePacket had mismatched buffer length (${rawData.length}) and declared packet length (${controlSegment.dataLength[0]})`);
		let containedPacket: AllPossibleRawPackets;

		switch (controlSegment.operationType) {
			case OperationType.NoOperation: {
				throw new Error("Unimplemented op type");
			}
			case OperationType.RegisterDevice: {
				containedPacket = new RawRegistrationPacket(rawData.slice(RawPacketControlSegment.SIZE, RawPacketControlSegment.SIZE + RawRegistrationPacket.SIZE));
				break;
			}
			case OperationType.ForceUnregister: {
				throw new Error("Unimplemented op type");
			}
			case OperationType.InitiateConnection: {
				containedPacket = new RawInitiateConnectionPacket(rawData.slice(RawPacketControlSegment.SIZE, RawPacketControlSegment.SIZE + RawInitiateConnectionPacket.SIZE));
				break;
			}
			case OperationType.SetConfig: {
				throw new Error("Unimplemented op type");
			}
			case OperationType.GetConfig: {
				throw new Error("Unimplemented op type");
			}
			case OperationType.GetCaps: {
				throw new Error("Unimplemented op type");
			}
			case OperationType.BeginStream: {
				//throw new Error("Unimplemented op type");
				containedPacket = new NoOperationPacket(); // Empty 
				break;
			}
			case OperationType.StopStream: {
				throw new Error("Unimplemented op type");
			}
			case OperationType.BeginMotionAnalysis: {
				throw new Error("Unimplemented op type");
			}
			case OperationType.StopMotionAnalysis: {
				throw new Error("Unimplemented op type");
			}
			case OperationType.ShutdownAnalyzerEnergySaving: {
				throw new Error("Unimplemented op type");
			}
			case OperationType.WakeupAnalyzerEnergySaving: {
				throw new Error("Unimplemented op type");
			}
			case OperationType.ShutdownNetworkEnergySaving: {
				throw new Error("Unimplemented op type");
			}
			case OperationType.ShutdownNetworkEnergySavingSchedule: {
				throw new Error("Unimplemented op type");
			}
			case OperationType.SleepEnergySavingSchedule: {
				throw new Error("Unimplemented op type");
			}
			case OperationType.__SendOTAUpdate: {
				throw new Error("Unimplemented op type");
			}
			case OperationType.Reset: {
				throw new Error("Unimplemented op type");
			}
			case OperationType.GetDeviceInfo: {
				throw new Error("Unimplemented op type");
			}
			case OperationType.Unknown: {
				throw new Error("Unimplemented op type");
			}
			default: {
				throw new Error("Unimplemented op type");
			}
		}

		return new PacketData(controlSegment, containedPacket);
	}

	serialize(): Uint8Array {
		const result = new Uint8Array(this.controlSegment.dataLength[0] + RawPacketControlSegment.SIZE);
		result.set(this.controlSegment.serialize());
		result.set(this.messageContent.serialize(), RawPacketControlSegment.SIZE);
		return result;
	}
}

/**
 * Raw version of application_control_segment_info_t in server_communications.c
 * Deserialized but not transformed to something more useful
 */
class RawPacketControlSegment {
	static SIZE = 21;                     // Sum of all field lengths

	sessionID = new Uint8Array(16);       // COMM_CSID_LENGTH in server_communications.c
	dataLength = new Uint8Array(4);       // Actually a 32 bit unsigned number but let's roll with raw bytes for now
	operationByte = new Uint8Array(1);    // Actually a MessageFromDevice or a MessageToDevice

	static fromRawBytes(rawData: Uint8Array): RawPacketControlSegment {
		if (rawData.length != RawPacketControlSegment.SIZE) throw new Error(`Raw data for RawPacketControlSegment was of invalid size: ${rawData.length}`);
		const result = new RawPacketControlSegment();
		result.sessionID = rawData.slice(0, 16);
		result.dataLength = rawData.slice(16, 20);
		result.operationByte = rawData.slice(20); // gross, get last element
		return result;
	}
}

/**
 * application_control_segment_info_t in server_communications.c
 * More useful form
 */
export class PacketControlSegment {
	sessionID = new Uint8Array(16);
	/**
	 * Contains a single 32 bit number
	 */
	dataLength = new Uint32Array(1);
	operationType = OperationType.Unknown;
	isResponse = false;
	
	/**
	 * @param rawData Bytes representing data length are in small endian
	 */
	static makeFromRawBytes(rawData: Uint8Array): PacketControlSegment {
		const result = new PacketControlSegment();
		const rawPacket = RawPacketControlSegment.fromRawBytes(rawData);
		result.sessionID = rawPacket.sessionID;
		result.dataLength = new Uint32Array(rawPacket.dataLength.buffer);
		// Check if most significant bit is set
		if (rawPacket.operationByte[0] & 0b10000000) {
			result.isResponse = true;
			rawPacket.operationByte[0] -= 128; // Clear MSB to normalize message
			                                   // In the most stupid way possible but because JS doesn't conceive of Uint8s from Uint8Arrays, this requires a subtraction
		};
		switch (rawPacket.operationByte[0]) {
			// Mappings from server_communications.c
			case 0x0: {
				result.operationType = OperationType.NoOperation;
				break;
			}
			case 0x1: {
				result.operationType = OperationType.RegisterDevice;
				break;
			}
			case 0x2: {
				result.operationType = OperationType.ForceUnregister;
				break;
			}
			case 0x3: {
				result.operationType = OperationType.InitiateConnection;
				break;
			}
			case 0x4: {
				result.operationType = OperationType.SetConfig;
				break;
			}
			case 0x5: {
				result.operationType = OperationType.GetConfig;
				break;
			}
			case 0x6: {
				result.operationType = OperationType.GetCaps;
				break;
			}
			case 0x7: {
				result.operationType = OperationType.BeginStream;
				break;
			}
			case 0x8: {
				result.operationType = OperationType.StopStream;
				break;
			}
			case 0x9: {
				result.operationType = OperationType.BeginMotionAnalysis;
				break;
			}
			case 0xA: {
				result.operationType = OperationType.StopMotionAnalysis;
				break;
			}
			case 0xB: {
				result.operationType = OperationType.ShutdownAnalyzerEnergySaving;
				break;
			}
			case 0xC: {
				result.operationType = OperationType.WakeupAnalyzerEnergySaving;
				break;
			}
			case 0xD: {
				result.operationType = OperationType.ShutdownNetworkEnergySaving;
				break;
			}
			case 0xE: {
				result.operationType = OperationType.ShutdownNetworkEnergySavingSchedule;
				break;
			}
			case 0xF: {
				result.operationType = OperationType.SleepEnergySavingSchedule;
				break;
			}
			case 0x10: {
				result.operationType = OperationType.__SendOTAUpdate;
				break;
			}
			case 0x11: {
				result.operationType = OperationType.Reset;
				break;
			}
			case 0x12: {
				result.operationType = OperationType.GetDeviceInfo;
				break;
			}
			default: {
				result.operationType = OperationType.Unknown;
				break;
			}
		}

		return result;
	}

	serialize(): Uint8Array {
		const result = new Uint8Array(RawPacketControlSegment.SIZE);
		result.set(this.sessionID);
		result.set(new Uint8Array(this.dataLength.buffer), this.sessionID.length);
		result[20] = this.operationType + (this.isResponse ? 128 : 0);
		return result;
	}
}

// https://www.protlr.com/example

/**
 * Packet for RegisterDevice, deserialized but not transformed to something more useful
 * same struct as application_registration_section_t in server_communications.c
 */
export class RawRegistrationPacket {
	static SIZE = 54;                     // Sum of all field lengths

	userID = new Uint8Array(16);          // MAX_USER_ID_LENGTH in registration.h
	cameraID = new Uint8Array(16);        // CID_LENGTH in registration.h
	cameraAuthKey = new Uint8Array(16);   // CKEY_LENGTH in registration.h
	deviceMacAddress = new Uint8Array(6); // COMM_NETIF_WIFI_STA_MAC_ADDR_LENGTH in server_communications.c

	/**
	 * Does not decode the auth key because the auth key will always be empty
	 */
	constructor(rawData: Uint8Array) {
		if (rawData.length != RawRegistrationPacket.SIZE) throw new Error(`Raw data for RawRegistrationPacket was of invalid size: ${rawData.length}`);
		this.userID = rawData.slice(0, 16);
		this.cameraID = rawData.slice(16, 32);
		this.cameraAuthKey = rawData.slice(32, 48);
		this.deviceMacAddress = rawData.slice(48, 54);
	}

	serialize(): Uint8Array {
		const result = new Uint8Array(RawRegistrationPacket.SIZE);
		result.set(this.userID);
		result.set(this.cameraID, this.userID.length);
		result.set(this.cameraAuthKey, this.userID.length + this.cameraID.length);
		result.set(this.deviceMacAddress, this.userID.length + this.cameraID.length + this.cameraAuthKey.length);
		return result;
	}
}

/**
 * Packet for InitiateConnection, deserialized but not transformed to something more useful
 * Same struct as application_initcomm_section_t in server_communications.c
 */
export class RawInitiateConnectionPacket {
	static SIZE = 32;                     // Sum of all field lengths

	cameraID = new Uint8Array(16);        // CID_LENGTH in registration.h
	cameraAuthKey = new Uint8Array(16);   // CKEY_LENGTH in registration.h
	
	constructor(rawData: Uint8Array) {
		if (rawData.length != RawInitiateConnectionPacket.SIZE) throw new Error(`Raw data for RawInitiateConnectionPacket was of invalid size: ${rawData.length}`);
		this.cameraID = rawData.slice(0, 16);
		this.cameraAuthKey = rawData.slice(16, 32);
	}

	serialize(): Uint8Array {
		const result = new Uint8Array(RawInitiateConnectionPacket.SIZE);
		result.set(this.cameraID);
		result.set(this.cameraAuthKey, this.cameraID.length);
		return result;
	}
}

export class NoOperationPacket {
	static SIZE = 0;

	serialize(): Uint8Array {
		return new Uint8Array(NoOperationPacket.SIZE);
	}
}

export class RawUnregisterPacket {
	static SIZE = 1;

	succeeded = new Uint8Array(1); // simple bool flag

	constructor(rawData: Uint8Array) {
		if (rawData.length != RawUnregisterPacket.SIZE) throw new Error(`Raw data for RawUnregisterPacket was of invalid size: ${rawData.length}`);
		this.succeeded = rawData.slice(0, 1);
	}

	serialize(): Uint8Array {
		const result = new Uint8Array(RawUnregisterPacket.SIZE);
		result.set(this.succeeded);
		return result;
	}
}



/* ================
 * | UDP ELEMENTS |
 * ================ */

export enum ImagePacketType {
	MiddleChunk,            // JFIF_INTERMEDIATE_CHUNK
	FirstChunk,             // JFIF_FIRST_CHUNK
	LastChunk,              // JFIF_LAST_CHUNK
	OnlyChunk,              // JFIF_ONLY_CHUNK
}

export class ImagePacket {
	packetID = new Uint32Array(1);
	packetType = ImagePacketType.OnlyChunk;
	sessionID = new Uint8Array(16);
	data = new Uint8Array(16354);

	static makeFromRawBytes(rawData: Uint8Array): ImagePacket {
		const rawPacket = RawImagePacket.makeFromRawBytes(rawData);
		const result = new ImagePacket();

		result.packetID = new Uint32Array(rawPacket.packetID.buffer);
		switch (rawPacket.packetType[0]) {
			case 0x00: {
				result.packetType = ImagePacketType.MiddleChunk
				break;
			}
			case 0x01: {
				result.packetType = ImagePacketType.FirstChunk;
				break;
			}
			case 0x02: {
				result.packetType = ImagePacketType.LastChunk;
				break;
			}
			case 0x03: {
				result.packetType = ImagePacketType.OnlyChunk;
				break;
			}
			default: {
				throw new Error("unknown packet type byte");
			}
		}
		result.sessionID = rawPacket.sessionID;
		result.data = rawPacket.data;

		return result;
	}
}

class RawImagePacket {
	static SIZE = 16384;

	packetID = new Uint8Array(4);     // 32-bit number
	packetType = new Uint8Array(1);   // Representation of ImagePacketType
	sessionID = new Uint8Array(16);   // COMM_CSID_LENGTH in server_communications.c
	data = new Uint8Array(16354);     // As per the documentation

	static makeFromRawBytes(rawData: Uint8Array): RawImagePacket {
		if (rawData.length != RawImagePacket.SIZE) throw new Error(`rawData passed to RawImagePacket.makeFromRawBytes was too short: ${rawData.length}`);
		const result = new RawImagePacket();

		result.packetID = rawData.slice(0, 4);
		result.packetType = rawData.slice(4, 5);
		result.sessionID = rawData.slice(5, 21);
		result.data = rawData.slice(21);

		return result;
	}
}