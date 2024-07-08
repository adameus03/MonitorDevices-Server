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
    console.log("[dbg] In /login handler");
    if (req.body.email && req.body.password) {
	console.log("[dbg] In /login email&password condition");
        try {
            let user = await userManager.LoginUser(req.body.email, req.body.password);
            if (user) {
		console.log("[dbg] In /login if(user)");
                var rand = Math.random();
                var token = await userUtils.generate_token(rand.toString(), req.body.email);
                if (token != null) {
		    console.log("[dbg] In /login if(token != null)");
                    await userUtils.save_token(token, req.body.email);
		    console.log("[dbg] In /login before res.setHeader");
                    await res.setHeader('Authorization', token);
                }
		console.log(`UUUUU USERNAME: ${user.get('username')}`);
                res.status(200).json({ 
		    username: user.get('username'), 
                    user_id: user.get("user_id")
		});
                console.log("-- [login] after res,sendStatus --");
            } else {
		console.log("[dbg] In /login else(user)");
                next(createError(400, "INVALID EMAIL OR PASSWORD"));
                next();
            } 
        } catch (e) {
	    console.log(`[dbg] In /login CATCHED ERROR: ${e}`);
	    console.log("[dbg] In /login catch(e)");
            next(createError(500, 'INTERNAL SERVER ERROR' + e));
	    console.log("[dbg] In /login catch(e) after next(createError)");
            next();
        }
    } else {
	console.log("[dbg] In /login else clause of email&password");
        next(createError(400, 'ONE OF THE REQUIRED FIELDS IS MISSING'));
        next();
    }
})

router.post("/check-token", async (req, res, next) => {
    console.log("--- In check-token --");
    if (req.body.token && req.body.email) {
	console.log("-- Condition satisfied --");
        var temp = await userUtils.verify_token(req.body.token, req.body.email);
        if (temp == true) {
            await userUtils.refresh_token(req.body.token);
            res.sendStatus(200);
        } else if (temp == false) {
            next(createError(400, "INVALID TOKEN"));
            next();
        } else {
            next(createError(500, "INTERNAL SERVER ERROR"));
            next();
        }
        //next(createError(400, "INVALID TOKEN"));
        //next();
    } else {
    	console.log("-- Condition NOT satisfied --");
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

