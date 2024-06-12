/* Entry point for the application */

import express from 'express';
import userRoutes from './modules/user_management/routes/userRoutes';
import deviceRoutes from './modules/device_management/routes/deviceRoutes';
import { DeviceConnectingServer } from "./device_bridge/app";
import { WebSocketExpress, Router } from 'websocket-express';
import { randomFillSync } from 'crypto';

const app = new WebSocketExpress();

app.use(express.json());
app.use(userRoutes.router);
app.use(deviceRoutes.router);
const server = app.createServer();
server.listen(8091, "0.0.0.0");

let userIDBuffer = new Uint8Array(16);
randomFillSync(userIDBuffer);
var a = Buffer.from(userIDBuffer).toString('utf8');
console.log(Buffer.from(userIDBuffer));
console.log(a);
var b = Buffer.from(a, 'utf8');
console.log(b);
console.log(b.toString('utf8'));

// Set up the device server to be globally available
const deviceServer = new DeviceConnectingServer();
deviceServer.start(3333);
app.locals["deviceConnector"] = deviceServer;

export default app; // Export the app object as the default export