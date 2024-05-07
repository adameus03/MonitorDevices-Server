import jwt from "jsonwebtoken";
import { QueryTypes, where } from "sequelize";
import { Database } from "sqlite3";
 
import db from '../../shared/database';
import e from "express";
    
export class Utils {

    async getEmailByUsername(username: string) {
        try {
            var temp = await db.User.findOne({ where: { username: username } });
            var email = temp?.dataValues.email;
            return email;
        } catch (error) {
            return null;
        }
    }

    async generate_token (key: string, email: string) {
        return await jwt.sign({ email: email } , key, { expiresIn: "30h" });
    }; 

    async verify_token(token: string, email: string) {
        try {
            var temp = await db.AuthenticationToken.findOne({ where: { token: token, email: email } });
            if (temp != null && !(await this.isTokenExpired(token))) {
                return true;
            } else {
                return false;
            }
        } catch (error) {
            return error;
        }
    }

    async isTokenExpired(token: string) {
    try {
        const authToken = await db.AuthenticationToken.findOne({ where: { token: token } });

        if (!authToken) {
            return true; 
        }

        var expired_date = authToken?.dataValues.expired_date;
        
        return expired_date <= new Date(); 
    } catch (error) {
        return true;
    }
}

    async save_token(token: string, email: string) {
        const date = new Date();
        date.setDate(date.getDate() + 30);
        var sqliteDate = date.toISOString().slice(0, 19).replace('T', ' ');
        try {
            let t: any = await db.AuthenticationToken.create({
                token: token,
                email: email,
                expired_date: sqliteDate,
            });
        } catch (error) {
            console.log(error);
        }
    }

    async refresh_token(token: string) {
        const date = new Date();
        date.setDate(date.getDate() + 30);
        try {
            db.AuthenticationToken.update({ expired_date: date }, { where: { token: token } });
            return null;
        } catch (error) {
            return error;
        }
    }

    async isTokenExists(token: string) {
        try {
            var temp = db.AuthenticationToken.findOne({ where: { token: token } })
        } catch (error) {
            return error;
        }
        if (temp != null) {
            return true;
        } else {
            return false;
        }
    }


    private static _instance: Utils
    public static getInstance(): Utils {
        if (!this._instance) this._instance = new Utils()
        return this._instance
    }
}

export default Utils.getInstance();