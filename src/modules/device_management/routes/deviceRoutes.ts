﻿import createError from 'http-errors';
import { Router } from 'websocket-express';
import userManager from "../../user_management/model/UserManager";
import DeviceManager from "../model/DeviceManager";
import db from "../../../shared/database";
import { Model, UnknownConstraintError } from 'sequelize';
import { type } from 'os';
import { isUtf8 } from 'buffer';
import { ConnectedDevice } from '../../../device_bridge/app';

const router = new Router();

interface Client {
    username: string;
    ws: any;
}

let clients: Client[] = [];

// GET devices by username
router.get("/users/:user_name/devices", async (req, res, next) => {
    const user_name = req.params.user_name;

    try {
        if (await userManager.DoesUserExist(user_name)) {
            const devices = await DeviceManager.GetDevicesByUser(user_name);
            if (devices instanceof Error) {
                return next(createError(500, "Failed to fetch devices by user ID"));
            } else {
                return res.status(200).send(devices);
            }
        } else {
            return next(createError(400, "User not found"));
        }
    } catch (error) {
        return next(createError(500, "Internal Server Error"));
    }
});

// WebSocket connection
router.ws('/web-socket', async (req, res) => {
    let ws = await res.accept();
    try {
        const username = req.query.username?.toString();

        if (typeof username !== 'string') {
            ws.close(400, 'Username is required and must be a string');
            return;
        }

        clients.push({ username, ws });
        console.log("New connection " + username);

        //Check username
        const user = await db.User.findOne({ where: { username: username } });          
        if (!user || typeof user.get("username") !== 'string') {
            ws.close(400, 'User does not exist');
            clients = clients.filter(client => client.username !== username);
            return;
        }
        let s = user.get('username');

        //Get user devices
        let devices: string | Model<any, any>[];                                          
        devices = await DeviceManager.GetDevicesByUser(username);
            if (devices instanceof Error) {
                ws.close(500, 'Iternal server error');
                clients = clients.filter(client => client.username !== username);
            return;
        }

        //Send to client list of devices
        if (devices && typeof devices != 'string') {                                        
            const deviceList = devices.map(device => ({
                id: device.get('device_id'),
                createdAt: device.get('createdAt')
            }));

            // Declare session here to use it in both ws handlers
            let session: ConnectedDevice;

            ws.send(JSON.stringify({ type: 'device_list', devices: deviceList }));

            ws.on('message', async (message) => {
                 console.log("@@@ ws.on('message', ...) @@@");
		 try {
	            console.log("@@@ before JSON.parse @@@");
                    let data = JSON.parse(message.toString('utf-8'));
	            console.log("@@@ After JSON.parse @@@");
                    if (data.type === 'select_device') {
			console.log("@@@ data.type === 'select_device' @@@");
                        //Get buffer id from websocket message
                        let selectedDeviceId = Buffer.from(data.device_id.data);
			console.log("@@@ After Buffer.from @@@");
                        if (typeof devices != 'string') {
		            console.log("@@@ data.type === 'select_device' @@@");
                            let selectedDevice;
                            //Find received id in devices
                            for (let i = 0; i < devices.length; i++) {                     
                                if (devices[i].get('device_id') == selectedDeviceId.toString()) {
                                    selectedDevice = devices[i];
                                    break;
                                }
                            }

                            if (!selectedDevice) {
				console.log("@@@ !selectedDevice @@@");
                                ws.send(JSON.stringify({ type: 'error', message: 'Invalid device ID' }));
                                return;
                            }
			    console.log("@@@ selectedDevice @@@");

                            //Get device id as a buffer and find session to this device_id
                            const device_id = new Uint8Array(selectedDevice.get('device_id') as Buffer);    
			    console.log("@@@ before deviceConnector.getSessionByDeviceID @@@");
                            session = req.app.locals.deviceConnector.getSessionByDeviceID(device_id); // using outer scope session
			    console.log("@@@ after deviceConnector.getSessionByDeviceID @@@");

                            if (!session || typeof session == undefined) {
				console.log("@@@ !session || typeof session == undefined @@@");
                                ws.send(JSON.stringify({ type: 'error', message: 'No session for this device' }));
				console.log("@@@ Sent 'No session for this device' @@@");
                                return;
                            }

                            

                            //Send frames
                            session.videoManager.on('newFrame', (frameData: any) => {                       
                                console.log(`New frame received from device ${session.deviceID}`);
                                ws.send(frameData);
                            });

                            session.beginStream();
                        }
                    } else {
			console.log("@@@ else @@@");
                    }
                } catch (error) {
		    console.log("@@@ catch (error) @@@");
		    console.log(`@@@ error = ${error} @@@`);
                    ws.send(JSON.stringify({ type: 'error', message: 'Internal Server Error' }));
                }
            });

            ws.on('close', () => {
                console.log('Close connection ' + username);
                clients = clients.filter(client => client.username !== username);

                session.endStream();
            });
        } else {
            ws.close(500, 'Iternal server error');
            clients = clients.filter(client => client.username !== username);
        }
    } catch (error) {
	console.log("@@@ In error before ws.close @@@");
        ws.close(500, 'Internal Server Error');
    }
});

export default {
    router,
};
