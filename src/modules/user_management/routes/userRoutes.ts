import express from "express";
import createError from 'http-errors';

import db from "../../../shared/database";
import userManager from "../model/UserManager";
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

export default {
    router: router
}

