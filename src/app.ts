/* Entry point for the application */

import express from 'express';
import userRoutes from './modules/user_management/routes/userRoutes';
import deviceRoutes from './modules/device_management/routes/deviceRoutes';
import videosApi from './modules/persistence/routes/videosApi'
import { DeviceConnectingServer } from "./device_bridge/app";
import { WebSocketExpress, Router } from 'websocket-express';
import { randomFillSync } from 'crypto';
import { DevbridgeGlue } from './analyser_bridge/devbridgeGlue_main';
import { NotificationRequestListener } from './modules/notifications/NotificationRequestListener';

Error.stackTraceLimit = Infinity; // Prevent stack traces from being truncated

export const app = new WebSocketExpress();

app.use(express.json());
app.use(userRoutes.router);
app.use(deviceRoutes.router);
app.use(videosApi.router);

// Set up the device server to be globally available
export const deviceServer = new DeviceConnectingServer();
deviceServer.startTCP(3334);
deviceServer.startUDP(3333);

app.locals["deviceConnector"] = deviceServer;

export const inferringService = new DevbridgeGlue();
app.locals["inferringService"] = inferringService;

let notificationRequestListener: NotificationRequestListener = new NotificationRequestListener();

notificationRequestListener.start();
inferringService.start();

export default app; // Export the app object as the default export
