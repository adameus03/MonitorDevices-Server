import db from "../../../shared/database";

export class DeviceManager {
    async CreateDevice (mac_address: String, user_id: String) {
        if (await db.Device.findOne({where: {mac_address: mac_address}}))
            return "MAC ADDRESS ALREADY EXISTS";
        if (!(await db.User.findOne({where: {user_id: user_id}})))
            return "USER NOT FOUND";
        let d: any = await db.Device.create({
            mac_address: mac_address,
            user_id: user_id,
        });
        return null;
    }

    async GetDevicesByUser (user_id: any) {
        try {
            const devices = await db.Device.findAll ({
                where: {
                    user_id: user_id,
                }
            });
            return devices;
        } catch {
            return "INTERNAL SERVER ERROR";
        }   
        
    }


    private static _instance: DeviceManager
    public static getInstance(): DeviceManager {
        if (!this._instance) this._instance = new DeviceManager()
        return this._instance
      }
}

export default DeviceManager.getInstance();