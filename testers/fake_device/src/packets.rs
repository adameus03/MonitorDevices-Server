use std::{io::Read, net::TcpStream};

use deku::prelude::*;

const IMAGE_CHUNK_MAX_SIZE: usize = 16354;

#[derive(Debug, Clone, Copy, DekuRead, DekuWrite, PartialEq, Eq)]
pub struct ApplicationPacket {
	pub session_id: [u8; 16],
	#[deku(endian = "little")]
	pub buffer_size: u32,
	#[deku(bits = "1")]
	pub is_response: bool,
	pub message: Message,
}

#[derive(Debug, Clone, Copy, DekuRead, DekuWrite, PartialEq, Eq)]
#[deku(id_type = "u8", bits = 7)]
pub enum Message {
	#[deku(id = "0x00")]
	NoOperation(EmptyPacket),
	#[deku(id = "0x01")]
	RegisterDevice(RegisterDevicePacket),
	#[deku(id = "0x02")]
	UnregisterDevice(UnregisterDevicePacket),
	#[deku(id = "0x03")]
	InitiateConnection(InitiateConnectionPacket),
}

#[derive(Debug, Clone, Copy, DekuRead, DekuWrite, PartialEq, Eq)]
pub struct EmptyPacket {}

#[derive(Debug, Clone, Copy, DekuRead, DekuWrite, PartialEq, Eq)]
pub struct RegisterDevicePacket {
	pub user_id: [u8; 16],
	pub camera_id: [u8; 16],
	pub auth_key: [u8; 16],
	pub mac_address: [u8; 6],
}

#[derive(Debug, Clone, Copy, DekuRead, DekuWrite, PartialEq, Eq)]
pub struct InitiateConnectionPacket {
	pub camera_id: [u8; 16],
	pub auth_key: [u8; 16],
}

#[derive(Debug, Clone, Copy, DekuRead, DekuWrite, PartialEq, Eq)]
pub struct UnregisterDevicePacket {
	pub success: u8,
}

#[derive(Debug, Clone, Copy, DekuRead, DekuWrite, PartialEq, Eq)]
#[deku(id_type = "u8")]
pub enum ImageChunkType {
	MiddleChunk = 0x00,
	FirstChunk = 0x01,
	LastChunk = 0x02,
	OnlyChunk = 0x03,
}

#[derive(Debug, Clone, DekuRead, DekuWrite, PartialEq, Eq)]
pub struct ImageChunk {
	pub chunk_id: u32,
	pub chunk_type: ImageChunkType,
	pub session_id: [u8; 16],
	#[deku(read_all)]
	pub image_bytes: Vec<u8>,
}

pub fn get_packet_from_socket(stream: &mut TcpStream) -> Result<ApplicationPacket, DekuError> {
	let mut main_buffer = vec![0; 21]; // session_id, data length and response/type
	stream.read_exact(&mut main_buffer).unwrap();

	let size = u32::from_le_bytes(main_buffer[16..20].try_into().unwrap());

	assert!(size < 100, "Size is suspiciously large");

	let mut data = vec![0; size as usize];
	stream.read_exact(&mut data).unwrap();

	main_buffer.append(&mut data);

	return ApplicationPacket::try_from(main_buffer.as_ref());
}

pub fn split_bytes_into_image_chunks(input: &[u8], packet_id_offset: u32, session_id: [u8; 16]) -> Vec<ImageChunk> {
	if input.len() <= IMAGE_CHUNK_MAX_SIZE {
		return vec![
			ImageChunk {
				chunk_id: packet_id_offset,
				chunk_type: ImageChunkType::OnlyChunk,
				session_id,
				image_bytes: Vec::from(input),
			}
		];
	}

	// we need multiple parts
	let first_slice = &input[0..IMAGE_CHUNK_MAX_SIZE];
	let mut unprocessed_bytes = input.len() - IMAGE_CHUNK_MAX_SIZE;
	let mut result = vec![
		ImageChunk {
			chunk_id: packet_id_offset,
			chunk_type: ImageChunkType::FirstChunk,
			session_id,
			image_bytes: Vec::from(first_slice),
		}
	];
	let mut packet_count: usize = 1;

	while unprocessed_bytes > IMAGE_CHUNK_MAX_SIZE {
		result.push(ImageChunk {
			chunk_id: packet_id_offset + packet_count as u32,
			chunk_type: ImageChunkType::MiddleChunk,
			session_id,
			image_bytes: Vec::from(&input[(IMAGE_CHUNK_MAX_SIZE * packet_count)..(IMAGE_CHUNK_MAX_SIZE * (packet_count + 1))]),
		});
		packet_count += 1;
		unprocessed_bytes -= IMAGE_CHUNK_MAX_SIZE;
	}

	result.push(ImageChunk {
		chunk_id: packet_id_offset + packet_count as u32,
		chunk_type: ImageChunkType::LastChunk,
		session_id,
		image_bytes: Vec::from(&input[(IMAGE_CHUNK_MAX_SIZE * packet_count)..]),
	});

	return result;
}

#[cfg(test)]
mod test {
    use std::{assert_matches::assert_matches, mem::size_of};

    use deku::DekuContainerWrite;

    use crate::packets::{ApplicationPacket, Message};

    use super::{ImageChunk, ImageChunkType, InitiateConnectionPacket};

	#[test]
	fn decode_noop_request() {
		let data: [u8; _] = [
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0,
			0b0_0000000,
		];

		let decoded = ApplicationPacket::try_from(data.as_ref()).unwrap();
		assert_matches!(decoded.message, Message::NoOperation(_));
		assert!(!decoded.is_response);
	}

	#[test]
	fn decode_registration_response() {
		let data: [u8; _] = [
			0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
			54, 0, 0, 0,
			0b1_0000001,
			0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
			15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0,
			16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 29, 30, 31, 32,
			0, 1, 2, 3, 4, 5
		];

		let decoded = ApplicationPacket::try_from(data.as_ref()).unwrap();
		assert!(decoded.is_response);
		assert_eq!(decoded.buffer_size, 54);
		assert_eq!(decoded.session_id, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
		assert_matches!(decoded.message, Message::RegisterDevice(_));
		if let Message::RegisterDevice(inner) = decoded.message {
			assert_eq!(inner.user_id, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
			assert_eq!(inner.camera_id, [15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]);
			assert_eq!(inner.auth_key, [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 29, 30, 31, 32]);
			assert_eq!(inner.mac_address, [0, 1, 2, 3, 4, 5]);
		}
	}

	#[test]
	fn encode_initcomm_response() {
		let data = ApplicationPacket {
			session_id: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
			is_response: true,
			buffer_size: size_of::<InitiateConnectionPacket>() as u32,
			message: Message::InitiateConnection(InitiateConnectionPacket {
				auth_key: [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 29, 30, 31, 32],
				camera_id: [15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
			})
		};

		let encoded = data.to_bytes().unwrap();
		assert_eq!(encoded, vec![
			0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
			32, 0, 0, 0,
			0b1_0000011, // 0x03 + response
			15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0,
			16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 29, 30, 31, 32
		]);
	}

	#[test]
	fn image_chunk() {
		let data = ImageChunk {
			chunk_id: 5, 
			chunk_type: ImageChunkType::MiddleChunk,
			session_id: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
			image_bytes: vec![0; 16384],
		};

		let encoded = data.to_bytes().unwrap();
		assert_eq!(encoded.len(), 4 + 1 + 16 + 16384);

		let decoded = ImageChunk::try_from(encoded.as_ref()).unwrap();
		assert_eq!(decoded.chunk_id, 5);
		assert_eq!(decoded.chunk_type, ImageChunkType::MiddleChunk);
		assert_eq!(decoded.session_id, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
		assert_eq!(decoded.image_bytes.len(), 16384);
	}
}