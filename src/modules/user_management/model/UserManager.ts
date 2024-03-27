import db from "../../../shared/database";

export class UserManager {
    async CreateUser (username: String, password: String, email: String) {
        if (await db.User.findOne({where: {username: username}}))
            return "USERNAME ALREADY EXISTS";
        if (await db.User.findOne({where: {email: email}}))
            return "EMAIL ALREADY TAKEN";

        let u: any = await db.User.create({
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

    async GetUserData (user_id: String) {
        return db.User.findAll({where: { user_id: user_id}});
    }


    private static _instance: UserManager
    public static getInstance(): UserManager {
        if (!this._instance) this._instance = new UserManager()
        return this._instance
      }


}

export default UserManager.getInstance();