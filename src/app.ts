/* Entry point for the application */

import express from 'express';
import userRoutes from './modules/user_management/routes/userRoutes';
import deviceRoutes from './modules/device_management/routes/deviceRoutes';
import { DeviceConnectingServer } from "./device_bridge/app";
import { WebSocketExpress, Router } from 'websocket-express';
import { randomFillSync } from 'crypto';
import { DevbridgeGlue } from './analyser_bridge/devbridgeGlue_main';

export const app = new WebSocketExpress();

app.use(express.json());
app.use(userRoutes.router);
app.use(deviceRoutes.router);

// Set up the device server to be globally available
export const deviceServer = new DeviceConnectingServer();
deviceServer.start(3333);
app.locals["deviceConnector"] = deviceServer;

const inferringService = new DevbridgeGlue();
inferringService.start();

export default app; // Export the app object as the default export