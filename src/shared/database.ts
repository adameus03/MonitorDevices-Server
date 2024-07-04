/* Shared database connection and models */

import { Sequelize, DataTypes } from 'sequelize';
import sqlite3 from 'sqlite3';

// Utility function to determine the database storage path
const getStoragePath = () => {
  const dbName = "monitordevicesdb";
  let storagePath = `${process.env.SQLITE_DBS_LOCATION}/${dbName}.sqlite`;
  console.log(`Database Storage Path: ${storagePath}`);
  return storagePath;
};

// Initialize Sequelize with SQLite configuration
const sequelize = new Sequelize({
  dialect: "sqlite",
  dialectModule: sqlite3,
  storage: getStoragePath(), // Use the storage path from the environment variable or default
});

// User model
const User = sequelize.define('User', {
  user_id: {
    type: DataTypes.BLOB,
    allowNull: false,
    unique: true,
    primaryKey: true,
    validate: {
      customValidator(value: Buffer) {
        if (value.length != 16) {
          throw new Error(`user_id is of incorrect size: ${value.length}`);
        }
      }
    },
  },
  username: {
    type: DataTypes.STRING,
    allowNull: false,
    unique: true,
  },
  password: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  email: {
    type: DataTypes.STRING,
    primaryKey: true,
    allowNull: false,
    unique: true,
  },
  phone_number: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  wants_mail_notifications: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
  },
  wants_sms_notifications: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
  },
  wants_app_notifications: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
  }
}, {
  tableName: 'users',
});

// Device model
const Device = sequelize.define('Device', {
  device_id: {
    type: DataTypes.BLOB,
    allowNull: false,
    unique: true,
    primaryKey: true,
    validate: {
      customValidator(value: Buffer) {
        if (value.length != 16) {
          throw new Error(`device_id is of incorrect size: ${value.length}`);
        }
      }
    },
  },
  name: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  last_notification_datetime: {
    type: DataTypes.DATE,
    allowNull: true,
  },
  mac_address: {
    type: DataTypes.BLOB,
    allowNull: false,
    unique: true,
    validate: {
      customValidator(value: Buffer) {
        if (value.length != 6) {
          throw new Error(`mac_address is of incorrect size: ${value.length}`);
        }
      }
    },
  },
  auth_key: {
    type: DataTypes.BLOB,
    allowNull: false,
    validate: {
      customValidator(value: Buffer) {
        if (value.length != 16) {
          throw new Error(`auth_key is of incorrect size: ${value.length}`);
        }
      }
    },
  },
  registration_first_stage: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: true,
  },
  user_id: {
    type: DataTypes.BLOB,
    allowNull: false,
    validate: {
      customValidator(value: Buffer) {
        if (value.length != 16) {
          throw new Error(`user_id is of incorrect size: ${value.length}`);
        }
      }
    }
  }
}, {
  tableName: 'device',
});

// VideoClip model
const VideoClip = sequelize.define('VideoClip', {
  clip_id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
  },
  device_id: {// foreign key
    type: DataTypes.BLOB,
    allowNull: false,
    validate: {
      customValidator(value: Buffer) {
        if (value.length != 16) {
          throw new Error(`device_id is of incorrect size: ${value.length}`);
        }
      }
    }
  },
  save_timestamp: { //TODO store begin timestamp as well?
    type: DataTypes.DATE,
    allowNull: false,
  },
  vkey_hash: { // hash of the key to access the video clip
    type: DataTypes.STRING,
    allowNull: false,
    unique: true,
  }
}, {
  tableName: 'video_clip',
});

const AuthenticationToken = sequelize.define('AuthenticationToken', {
    token: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true
    },

    email: {
        type: DataTypes.STRING,
        allowNull: false,
        references: {
            model: User,
            key: "email",
        }
    },

    expired_date: {
        type: DataTypes.DATE,
        allowNull: false,
    },
}, {
    tableName: 'AuthenticationToken',
});

AuthenticationToken.belongsTo(User, { foreignKey: 'email' });

Device.belongsTo(User, {
  foreignKey: "user_id",
  targetKey: "user_id"
});
User.hasMany(Device, {
  foreignKey: "user_id",
  sourceKey: "user_id"
});

// Exports
export default {
  sequelize: sequelize,
  User: User,
  Device: Device,
  VideoClip: VideoClip,
  AuthenticationToken: AuthenticationToken,
};
