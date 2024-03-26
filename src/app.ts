/* Entry point for the application */

import express from 'express';
import userRoutes from './modules/user_management/routes/userRoutes';
import deviceRoutes from './modules/device_management/routes/deviceRoutes';

const app = express();
app.use(express.json());
app.use(userRoutes.router);
app.use(deviceRoutes.router);


export default app; // Export the app object as the default export
