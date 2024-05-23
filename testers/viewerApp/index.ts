import * as slint from "slint-ui"
import * as devices from "../../src/device_bridge/app"
import { getSync } from '@andreekeberg/imagedata'

const file = slint.loadFile("./testers/viewerApp/view.slint") as any;
const window = new file.MainWindow();

const server = new devices.DeviceConnectingServer();

server.on("deviceConnected", (connector: devices.ConnectedDevice) => {
	connector.videoManager.on("newFrame", (frame: Uint8Array) => {
		window.frame = getSync(Buffer.from(frame.buffer));
	});
});

server.start(8090);

window.run();