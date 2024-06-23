import EventEmitter from "events";
import { ImagePacket, ImagePacketType } from "./messages";
import { areUint8ArraysEqual } from "./utils";

/**
 * Only handles frames for one session.
 * Does not create any sockets - frames need to be received externally
 */
export class DeviceVideoManager extends EventEmitter {
	sessionID = new Uint8Array(16);       // COMM_CSID_LENGTH in server_communications.c
	packets: ImagePacket[] = [];          // Parts of frames, to be cleared when image is assembled to a final form

	constructor(sessionID: Uint8Array) {
		super();
		if (sessionID.length != 16) throw new Error(`Session ID passed to DeviceVideoManager was of incorrect size ${sessionID.length}`);
		this.sessionID = sessionID;
	}

	async addPacket(packet: ImagePacket) {
		//if (process.versions.bun) 
		console.log("====DEBUG adding image packet=====");

		if (!areUint8ArraysEqual(this.sessionID, packet.sessionID)) throw new Error("Session ID mismatch between packet and manager");
		if (this.packets.map(packet => packet.packetID[0]).includes(packet.packetID[0])) throw new Error(`Received double packet ID: ${packet.packetID[0]}`);
		
		console.log("$$$ Pushing packet");
		this.packets.push(packet);
		console.log("$$$ Pushed packet");
		if (packet.packetType == ImagePacketType.OnlyChunk || packet.packetType == ImagePacketType.LastChunk) {
			console.log("$$$ packet.packetType == ImagePacketType.OnlyChunk || packet.packetType == ImagePacketType.LastChunk");
			// Shouldn't need to cut off data after EOI marker - JFIF should handle it on its own
			const fullImageData = this.packets
				.sort((a, b) => a.packetID[0] - b.packetID[0])
				.map(packet => packet.data)
				.reduce((previousResult, currentPacket) => {
					const newResult = new Uint8Array(previousResult.length + currentPacket.length);
					newResult.set(previousResult, 0);
					newResult.set(currentPacket, previousResult.length);
					return newResult;
				});
			console.log("$$$ Emiting new frame...");
			this.emit("newFrame", fullImageData);
			console.log("$$$ Emitted new frame");
			this.packets = [];
		}
	}
}