import db from "../../../shared/database";

import Persistence from "../../persistence/exports/api";

/**
 * @warning This implementation uses null as a return value to indicate success. This is not a good practice.
 * @warning This implementation uses strings as return values to indicate errors. This is not a good practice.
 * @todo Refactor the original implementation to use a more descriptive return values.
 * @todo Refactor the original implementation to use a more streamlined error handling.
 * @assignedTo PavelRadkevich @deadline 2024-08-31 @status NOT_STARTED @mailNotifs
 */
export class DeviceManager {
    async CreateDevice (camera_id: Uint8Array, mac_address: Uint8Array, auth_key: Uint8Array, user_id: Uint8Array) {
        if (await db.Device.findOne({ where: { device_id: Buffer.from(camera_id) }})) {
            return "DEVICE ID ALREADY EXISTS";
        }
        if (await db.Device.findOne({where: {mac_address: Buffer.from(mac_address)}}))
            return "MAC ADDRESS ALREADY EXISTS";
        if (!(await db.User.findOne({where: {user_id: Buffer.from(user_id)}})))
            return "USER NOT FOUND";
        let d: any = await db.Device.create({
            device_id: Buffer.from(camera_id),
            mac_address: Buffer.from(mac_address),
            auth_key: Buffer.from(auth_key),
            user_id: Buffer.from(user_id),
        });

        // Notify the persistence module
        Persistence.DevStorageManager.createDevDirectory(camera_id);

        return null; 
    }

    async GetDeviceByID(camera_id: Uint8Array) {
        return db.Device.findOne({ where: { device_id: Buffer.from(camera_id) }});
    }

    async GetDevicesByUser (user_name: String) {
        const user = await db.User.findOne({ where: { username: user_name }});
        if (user == null) {
            return "USER DOES NOT EXIST";
        }

        try {
            const devices = await db.Device.findAll ({
                where: {
                    user_id: user.get("user_id"),
                }
            });
            return devices;
        } catch {
            return "INTERNAL SERVER ERROR";
        }   
        
    }

    async DeleteDeviceByID(camera_id: Uint8Array) {
        await db.Device.destroy({ where: { device_id: Buffer.from(camera_id) }});

        // Notify the persistence module
        Persistence.DevStorageManager.deleteDevDirectory(camera_id);
    }


    private static _instance: DeviceManager
    public static getInstance(): DeviceManager {
        if (!this._instance) this._instance = new DeviceManager()
        return this._instance
      }
}

export default DeviceManager.getInstance();
