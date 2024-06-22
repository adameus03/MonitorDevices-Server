import { ConnectedDevice } from "../device_bridge/app";

export class AnalysisResult {
    public readonly shouldNotify: boolean = false;

    constructor(shouldNotify: boolean) {
        this.shouldNotify = shouldNotify;
    }
}

export class AnalysisResultReport {
    connectedDevice: ConnectedDevice;
    frameData: Uint8Array; // JFIF frame data
    analysisResult: AnalysisResult;

    constructor(connectedDevice: ConnectedDevice, frameData: Uint8Array, analysisResult: AnalysisResult) {
        this.connectedDevice = connectedDevice;
        this.frameData = frameData;
        this.analysisResult = analysisResult;
    }

}