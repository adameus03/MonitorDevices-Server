import createError from 'http-errors';
import { Router } from 'websocket-express';

import userManager from "../../user_management/model/UserManager";
import DeviceManager from "../model/DeviceManager";
import app from "../../../app";


const router = new Router();

let clients: any[] = [];

// Registering has been removed - you do not register over http, you do that over raw TCP from the device

router.get("/users/:user_name/devices", async (req, res, next) => {
    const user_name = req.params.user_name;
    if (await userManager.DoesUserExist(user_name)) {
        const d = await DeviceManager.GetDevicesByUser(user_name);
        if (d instanceof Error) {
            next(createError(500, "Failed to fetch devices by user ID"));
            next();
        } else {
            res.status(200).send(d);
        }
    } else {
        next(createError(400, "User not found"));
        next();
    }
})


router.ws('/web-socket', async (req, res) => {
    const ws = await res.accept();
    var id = Math.random();
    clients[id] = ws;
    console.log("New connection " + id);

    let device_id = req.query.device_id?.toString();                        //bierzemy device_id z "query"
    //console.log(device_id);
    //console.log(device_id?.toString('hex'));
    if (typeof device_id !== 'string') {
        clients[id].close(4000, 'Device ID is required and must be a string');
        delete clients[id];
        return;
    }
    let device_id_byte = new TextEncoder().encode(device_id);   //konwersja w Uint8Array

    var session = req.app.locals.deviceConnector.getSessionByDeviceID(device_id_byte);    

    if (!session) {
        clients[id].close(4000, 'Device ID is incorrect');
        delete clients[id];
        return;
    }


    session.on('newFrame', (frameData: any) => {                //czekamy na framy
        console.log(`New frame received from device ${session?.deviceID}`);
        clients[id].send(frameData);                            //jak sa to wysyłąmy
    });

    ws.on('close', function () {
            console.log('Close connection ' + id);
            delete clients[id];
        });

});




export default {
    router: router,
}