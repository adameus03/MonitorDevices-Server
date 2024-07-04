import { DevStorageManager } from "../DevStorageManager"

class Persistence {
    private static _instance: Persistence
    public static getInstance () : Persistence {
      if (!this._instance) {
        this._instance = new Persistence(DevStorageManager.getInstance())
      }
      return this._instance
    }

    private constructor(DevStorageManager: DevStorageManager) {
        this.DevStorageManager = DevStorageManager
    }

    public DevStorageManager : DevStorageManager;
}

export default Persistence.getInstance();