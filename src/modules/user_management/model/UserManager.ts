import { randomFillSync } from "crypto";
import CryptoJS from 'crypto-js';
import db from "../../../shared/database";

export class UserManager {
    async CreateUser (username: string, password: string, email: string) {
        if (await db.User.findOne({where: {username: username}}))
            return "USERNAME ALREADY EXISTS";
        if (await db.User.findOne({where: {email: email}}))
            return "EMAIL ALREADY TAKEN";

        // user_id type is BLOB - needs manual init
        let userIDBuffer = new Uint8Array(16);
        do {
            randomFillSync(userIDBuffer);
        } while (await db.User.findOne( { where: { user_id: Buffer.from(userIDBuffer) } }));

        var hashPassword = CryptoJS.SHA256(password.toString());
        try {
            let u: any = await db.User.create({
                user_id: Buffer.from(userIDBuffer),
                username: username,
                password: hashPassword.toString(),
                email: email
            });
        } catch (error) {
            console.log(error);
            return error;
        }
        return null;
    }

    async LoginUser(email: string, password: string) {
        var hashedPassword = CryptoJS.SHA256(password.toString()).toString();
        return await db.User.findOne({where: {email: email, password: hashedPassword}})
    }

    async GetUserData (user_name: String) {
        return db.User.findAll({where: { username: user_name}});
    }

	async GetUserById(userID: Uint8Array) {
		return db.User.findOne({ where: { user_id: Buffer.from(userID) } });
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
