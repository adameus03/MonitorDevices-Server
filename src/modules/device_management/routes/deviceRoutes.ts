import express from "express";
import createError from 'http-errors';

import db from "../../../shared/database";
import deviceManager from "../model/DeviceManager";
import utils from "../utils"
import DeviceManager from "../model/DeviceManager";
import { error } from "console";
import { list } from "pm2";
import userManager from "../../user_management/model/UserManager";
const router = express.Router();

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




export default {
    router: router,
}