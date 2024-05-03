import { RawRegistrationPacket } from "./messages";

/**
 * 
 * @param data Packet to put auth key into.
 */
// data is pass by reference, no need to return
export function registerDevice(data: RawRegistrationPacket) {
	// Debug mode, run with bun instead of node
	if (process.versions.bun) {
		console.log("=====BUN enter registerDevice=====")
		data.cameraAuthKey = new Uint8Array([
			0x00, 0x01, 0x02, 0x03,
			0x04, 0x05, 0x06, 0x07,
			0x08, 0x09, 0x0A, 0x0B,
			0x0C, 0x0D, 0x0E, 0x0F,
		]);
		console.log("=====BUN exit registerDevice=====")
	}
}