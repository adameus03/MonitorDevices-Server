#![feature(assert_matches)]

use std::{assert_matches::assert_matches, fs::read, io::Write, mem::size_of, net::{TcpStream, UdpSocket}, path::PathBuf, thread, time::Duration};
use clap::Parser;
use deku::DekuContainerWrite;
use fake_device::packets::{get_packet_from_socket, split_bytes_into_image_chunks, ApplicationPacket, InitiateConnectionPacket, Message, RegisterDevicePacket};

#[derive(clap::Parser)]
struct Config {
	#[arg(long = "file-path", default_value = "./testFrame.jpg")]
	file_path: PathBuf,
}

fn main() {
	let config = Config::parse();

    println!("fake device starting");

	let image_file = read(config.file_path).unwrap();

	let mut stream = TcpStream::connect("127.0.0.1:3333").unwrap();
	let user_id = [0x61, 0x61, 0x61, 0x61, 0x61, 0x61, 0x61, 0x61, 0x62, 0x62, 0x62, 0x62, 0x62, 0x62, 0x62, 0x62]; // update as necessary - maybe include sqlx?

	let mac_addr: [u8; 6] = rand::random();
	let auth_key: [u8; 16] = rand::random();
	let mut session_id = [0u8; 16];
	let mut device_id = [0u8; 16];
	
	println!("Registration stage 1");
	
	let first_stage_packet = ApplicationPacket {
		buffer_size: size_of::<RegisterDevicePacket>() as u32,
		is_response: false,
		session_id,
		message: Message::RegisterDevice(RegisterDevicePacket {
			auth_key,
			camera_id: device_id,
			user_id,
			mac_address: mac_addr,
		})
	};
	let packet_bytes = first_stage_packet.to_bytes().unwrap();

	println!("Sending packet with length {}", packet_bytes.len());

	stream.write(&packet_bytes).unwrap();
	
	let response = get_packet_from_socket(&mut stream).unwrap();

	if let Message::RegisterDevice(RegisterDevicePacket { camera_id, .. }) = response.message {
		device_id = camera_id;
	}


	println!("Registration stage 2");

	let second_stage_packet = ApplicationPacket {
		buffer_size: size_of::<RegisterDevicePacket>() as u32,
		is_response: false,
		session_id,
		message: Message::RegisterDevice(RegisterDevicePacket {
			auth_key, camera_id: device_id, mac_address: mac_addr, user_id,
		}),
	};
	let packet_bytes = second_stage_packet.to_bytes().unwrap();

	println!("Sending packet with length {}", packet_bytes.len());
	stream.write(&packet_bytes).unwrap();
	let response = get_packet_from_socket(&mut stream);
	assert_matches!(response, Ok(_)); // make sure the response is valid

	println!("Initializing session");

	let connection_init_packet = ApplicationPacket {
		session_id,
		buffer_size: 32 as u32,
		is_response: false,
		message: Message::InitiateConnection(InitiateConnectionPacket {
			auth_key, camera_id: device_id,
		}),
	};
	let packet_bytes = connection_init_packet.to_bytes().unwrap();

	println!("Sending packet with length {}", packet_bytes.len());
	stream.write(&packet_bytes).unwrap();
	let response = get_packet_from_socket(&mut stream).unwrap();

	session_id = response.session_id;

	println!("Starting video stream");

	let sender = UdpSocket::bind("127.0.0.1:0").unwrap();
	sender.connect("127.0.0.1:3333").unwrap();
	let mut packet_counter = 0u32;

	loop {
		let frames = split_bytes_into_image_chunks(&image_file, packet_counter, session_id);
		packet_counter += frames.len() as u32;

		for frame in frames {
			let frame_packet_bytes = frame.to_bytes().unwrap();
			let bytes_sent = sender.send(&frame_packet_bytes).unwrap();
			//println!("Packet ID {} send {} bytes", packet_counter, bytes_sent);
			thread::sleep(Duration::from_millis(20));
		}
		thread::sleep(Duration::from_millis(200));
	}

}
