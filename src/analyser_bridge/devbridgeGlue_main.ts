import { ConnectedDevice, DeviceConnectingServer } from "../device_bridge/app";
import { app, deviceServer} from '../app';
import { EventEmitter } from 'events';
import { AnalyserGlue } from "./analyserGlue";
import { AnalysisResult, AnalysisResultReport } from "./analysisResult";


export class DevbridgeGlue extends EventEmitter {
    static TAG = "DevbrigeGlue";
    __deviceServer: DeviceConnectingServer
    analyser: AnalyserGlue
    constructor() {
        super();
        this.__deviceServer = deviceServer;
        this.analyser = new AnalyserGlue();
    }

    start() {
        this.__deviceServer.on("deviceConnected", (dev: ConnectedDevice) => {
            console.log(`[${DevbridgeGlue.TAG}] cam connected: ${dev.deviceID}`);
            dev.videoManager.on("newFrame", (frameData: Uint8Array) => {
                let analysisResult: AnalysisResult = this.analyser.processFrame(frameData);
                if (analysisResult.shouldNotify) {
                    console.log(`[${DevbridgeGlue.TAG}] Analysis result: should notify`);
                    let report: AnalysisResultReport = new AnalysisResultReport(dev, frameData, analysisResult);
                    this.emit("analysisResult", report);
                } else {
                    console.log(`[${DevbridgeGlue.TAG}] Analysis result: should not notify`);
                }
            });
        });
        this.__deviceServer.on("deviceDisconnected", (dev: ConnectedDevice) => {
            console.log(`[${DevbridgeGlue.TAG}] cam disconnected: ${dev.deviceID}`);
        });
    }
}
