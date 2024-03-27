import express from "express";
import createError from 'http-errors';

import db from "../../../shared/database";
import userManager from "../model/UserManager";
import utils from "../../device_management/utils";
import UserManager from "../model/UserManager";
const router = express.Router();

router.post("/register/user", async (req, res, next) => {
    if (req.body.username && req.body.password && req.body.email) {
        try {
            let s = await userManager.CreateUser(req.body.username, req.body.password, req.body.email);
            if (s == null) {
                res.sendStatus(200);
            } else {
                next(createError(400, s));
                next();
            }   
        } catch (e) {
            next(createError(500, 'INTERNAL SERVER ERROR' + e));
            next();
        }
    } else {
        next(createError(400, 'ONE OF THE REQUIRED FIELDS IS MISSING'));
        next();
    }
});

router.get("/login", async (req, res, next) => {
    if (req.body.username && req.body.password) {
        try {
            let s = await userManager.LoginUser(req.body.username, req.body.password);
            if (s == null) {
                res.sendStatus(200);
            } else {
                next(createError(400, s));
                next();
            } 
        } catch (e) {
            next(createError(500, 'INTERNAL SERVER ERROR' + e));
            next();
        }
    } else {
        next(createError(400, 'ONE OF THE REQUIRED FIELDS IS MISSING'));
        next();
    }
})

router.get("/users/:user_id", async (req, res, next) => {
    const user_id = req.params.user_id;
    const s = await utils.CheckUser_Id(user_id);
    if (s == null) {
        try {
            res.status(200).send(await UserManager.GetUserData(user_id));
        } catch {
            next(createError(500, 'INTERNAL SERVER ERROR'));
            next();
        }
    } else {
        next(createError(400, 'USER NOT FOUND'));
        next();
    }
   
})

export default {
    router: router
}

