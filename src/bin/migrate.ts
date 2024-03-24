//var db = require('../modules/user_management/database.js');
import db from '../shared/database.js';
db.sequelize.sync();