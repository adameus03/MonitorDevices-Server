import express from "express";
import createError from 'http-errors';

import db from "../../../shared/database";
import deviceManager from "../model/DeviceManager";
import utils from "../utils"
import DeviceManager from "../model/DeviceManager";
import { error } from "console";
const router = express.Router();

router.post("/register/device", async (req, res, next) => {
    if (req.body.mac_address && req.body.user_id) {
        try {
            let s = await deviceManager.CreateDevice(req.body.mac_address, req.body.user_id);
            if (s === null) {
                res.sendStatus(200);
            } else {
                next(createError(400, s));
                next();
            }   
        } catch (e) {
            next(createError(500, 'INTERNAL SERVER ERROR'));
            next();
        }
    } else {
        next(createError(400, 'ONE OF THE REQUIRED FIELDS IS MISSING'));
        next();
    }
})

/*router.get("/users/:user_id/devices", async (req, res, next) => {
    const user_id = req.params.user_id;
    console.log(user_id);
    let s = utils.CheckUser_Id(user_id) 
    if (s == null) {
        let d = DeviceManager.GetDevicesByUser(user_id);
        if (d instanceof Error) {
            next(createError(500, "Failed to fetch devices by user ID"));
            next();
        } else {
            res.status(200).send(d);
        }
    } else {
        next(createError(400, s));
        next();
    }
})
*/                                              //Zawsze wyskakuje ERROR BAD REQUEST przy sprawdzeniu czy istnieje user_id


export default {
    router: router,
}