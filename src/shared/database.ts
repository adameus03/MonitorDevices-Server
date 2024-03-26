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
    type: DataTypes.INTEGER,
    allowNull: false,
    unique: true,
    primaryKey: true,
    autoIncrement: true,
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
    allowNull: false,
    unique: true,
  }
}, {
  tableName: 'users',
});

const Device = sequelize.define('Device', {
  device_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    unique: true,
    primaryKey: true,
    autoIncrement: true,
  },
  mac_address: {
    type: DataTypes.STRING,
    allowNull: false,
    unique: true,
  }
}, {
  tableName: 'device',
});

User.hasMany(Device, { foreignKey: 'user_id' });
Device.belongsTo(User, { foreignKey: 'user_id' });

// Exports
export default {
  sequelize: sequelize,
  User: User,
  Device: Device,
};
