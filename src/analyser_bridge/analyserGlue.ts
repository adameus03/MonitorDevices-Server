import { AnalysisResult } from "./analysisResult";

const sauas = require('../../analysis/sauas/Debug/sauas.node')

export class AnalyserGlue {
    constructor() {
        // console.log("[AnalyserGlue] Initializing analyser...");
        // sauas.agent_init();
        //console.log("[AnalyserGlue] Analyser initialized");
        console.log("[AnalyserGlue] sauas.agent_init() is obsolete, skipping.");
    }

    processFrame(frameData: Uint8Array): AnalysisResult {
        let buf = Buffer.from(frameData);
        let _result: Number = sauas.agent_process_frame(buf);
        let result = _result.valueOf();
        if (result > 0) {
            return new AnalysisResult(true);
        } else {
            return new AnalysisResult(false);
        }
    }
}