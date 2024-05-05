import { error } from "console";
import jwt from "jsonwebtoken";

import db from '../../shared/database';

export class Utils {
    async generate_token (payload: any, key: string) {
        return jwt.sign(payload, key, { expiresIn: '30d' });
    }; 

    async verify_token(token: string, email: string) {
        try {
            var temp = await db.AuthenticationToken.findOne({ where: { token: token, email: email } });
            if (temp != null) {
                return true;
            } else {
                return false;
            }
        } catch (error) {
            return error;
        }
    }

    async save_token(token: string, username: string) {
        var date = new Date();
        var sqliteDate = date.toISOString;
        let t: any = await db.AuthenticationToken.create({
            token: token,
            username: username,
            expired_date: sqliteDate,
        });
    }


    private static _instance: Utils
    public static getInstance(): Utils {
        if (!this._instance) this._instance = new Utils()
        return this._instance
    }
}

export default Utils.getInstance();