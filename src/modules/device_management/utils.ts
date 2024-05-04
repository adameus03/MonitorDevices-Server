import db from "../../shared/database";
import createError from 'http-errors';

export class Utils {
    private static _instance: Utils
    public static getInstance(): Utils {
        if (!this._instance) this._instance = new Utils()
        return this._instance
      }
}

export default Utils.getInstance();