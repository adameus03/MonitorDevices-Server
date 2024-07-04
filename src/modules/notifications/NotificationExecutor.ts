import { AnalysisResultReport } from "../../analyser_bridge/analysisResult";
import { VideoClip } from "../persistence/VideoClip";

export interface NotificationExecutor {
    send(report: AnalysisResultReport): void;
    sendSummary(devID: string, videoClip: VideoClip): void;
}