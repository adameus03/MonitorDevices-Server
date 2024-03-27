import db from "../../shared/database";
import createError from 'http-errors';

export class Utils {
    async CheckUser_Id (user_id: any) {
        if (await db.User.findOne({where: {user_id: user_id}})) {
            return null;
        }
        else {
            return "USER NOT FOUND";
        }
    }

    private static _instance: Utils
    public static getInstance(): Utils {
        if (!this._instance) this._instance = new Utils()
        return this._instance
      }
}

export default Utils.getInstance();