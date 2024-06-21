import express from "express";
import createError from 'http-errors';

import db from "../../../shared/database";
import userManager from "../model/UserManager";
import userUtils from "../../user_management/utils";
import UserManager from "../model/UserManager";
import { AUTH } from "sqlite3";
import jwt, { JwtPayload } from "jsonwebtoken";
const router = express.Router();

router.post("/register/user", async (req, res, next) => {
    console.log(req.body)
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

router.post("/login", async (req, res, next) => {
    if (req.body.email && req.body.password) {
        try {
            let s = await userManager.LoginUser(req.body.email, req.body.password);
            if (s == null) {
                var rand = Math.random();
                var token = await userUtils.generate_token(rand.toString(), req.body.email);
                if (token != null) {
                    userUtils.save_token(token, req.body.email);
                    res.setHeader('Authorization', token);
                }
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

router.post("/check-token", async (req, res, next) => {
    if (req.body.token && req.body.email) {
        var temp = await userUtils.verify_token(req.body.token, req.body.email);
        if (temp == true) {
            userUtils.refresh_token(req.body.token);
            res.sendStatus(200);
        } else if (temp == false) {
            next(createError(400, "INVALID TOKEN"));
            next();
        } else {
            next(createError(500, "INTERNAL SERVER ERROR"));
            next();
        }
        next(createError(400, "INVALID TOKEN"));
        next();
    }
    
})

// Replaced with username - user id is binary and difficult to deal with
router.get("/users/:user_name", async (req, res, next) => {
    const user_name = req.params.user_name;
    const s = await userManager.DoesUserExist(user_name);
    if (s != null) {
        try {
            res.status(200).send(await UserManager.GetUserData(user_name));
        } catch {
            next(createError(500, 'INTERNAL SERVER ERROR'));
            next();
        }
    } else {
        next(createError(400, 'USER NOT FOUND'));
        next();
    }
   
})

router.get("/self_user", async (req, res, next) => {
	// Retrieve information (username only currently) about the self user based on the auth token
	let token = req.header("Authorization");
	if (!token) next(createError(401, "TOKEN NOT SUPPLIED"));
	token = token?.split(" ")[1];
	console.log(token);
	const jwtContent = jwt.decode(token as string, {
		complete: false
	}) as JwtPayload;
	console.log(jwtContent);
	const email = jwtContent["email"];
	if (!email) next(createError(401, "INVALID TOKEN"));
	const user = await db.User.findOne({ where: { email: email }});
	if (!user) next(createError(401, "INVALID TOKEN"));
	res.status(200).send({ username: user?.get("username") });
})

export default {
    router: router
}

