import { randomFillSync } from "crypto";
import db from "../../../shared/database";

export class UserManager {
    async CreateUser (username: String, password: String, email: String) {
        if (await db.User.findOne({where: {username: username}}))
            return "USERNAME ALREADY EXISTS";
        if (await db.User.findOne({where: {email: email}}))
            return "EMAIL ALREADY TAKEN";

        // user_id type is BLOB - needs manual init
        let userIDBuffer = new Uint8Array(16);
        do {
            randomFillSync(userIDBuffer);
        } while (await db.User.findOne( { where: { user_id: Buffer.from(userIDBuffer) } }));
        
        
        let u: any = await db.User.create({
            user_id: Buffer.from(userIDBuffer),
            username: username,
            password: password,
            email: email
        });
        return null;
    }

    async LoginUser (username: String, password: String) {
        if (await db.User.findOne({where: {username: username, password: password}})) {
            return null;
        } else {
            return "INVALID USERNAME OR PASSWORD";
        }
    }

    async GetUserData (user_name: String) {
        return db.User.findAll({where: { username: user_name}});
    }

    async DoesUserExist(user_name: String) {
        if (await db.User.findOne({where: {username: user_name}})) {
            return true;
        }
        return false;
    }


    private static _instance: UserManager
    public static getInstance(): UserManager {
        if (!this._instance) this._instance = new UserManager()
        return this._instance
      }


}

export default UserManager.getInstance();