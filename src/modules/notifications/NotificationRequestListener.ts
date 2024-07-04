import { DevbridgeGlue } from "../../analyser_bridge/devbridgeGlue_main";
import { AnalysisResult, AnalysisResultReport } from "../../analyser_bridge/analysisResult"
import { app, inferringService } from '../../app';
import db from '../../shared/database';
import { Mailer } from "./Mailer";

export class NotificationRequestListener {
    static TAG = "NotificationRequestListener";

    __inferringService: DevbridgeGlue;
    mailer: Mailer;

    constructor() {
        this.__inferringService = inferringService;
        this.mailer = new Mailer();
    }

    start() {
        this.__inferringService.on("notificationRequest", async (report: AnalysisResultReport) => {
            if (report.analysisResult.shouldNotify) {
                let dev = await db.Device.findOne({
                    where: {
                        device_id: Buffer.from(report.connectedDevice.deviceID)
                    }
                });
                let devOwner = await db.User.findOne({
                    where: {
                        user_id: dev?.get('user_id')
                    }
                });

                if (devOwner?.get('wants_mail_notifications') as boolean) {
                    this.mailer.send(report);
                }
            }
        });

        //Handle summary notification (e.g. send mail with video clip)
        this.__inferringService.on("summaryRequest", async (sreq) => {
            let dev = await db.Device.findOne({
                where: {
                    device_id: Buffer.from(sreq.deviceID)
                }
            }).catch((err) => {
                console.error(`[${NotificationRequestListener.TAG}] Error while querying device from db: ${err}`);
            });

            let devOwner = await db.User.findOne({
                where: {
                    user_id: dev?.get('user_id')
                }
            }).catch((err) => {
                console.error(`[${NotificationRequestListener.TAG}] Error while querying device owner from db: ${err}`);
            });

            if (devOwner?.get('wants_mail_notifications') as boolean) {
                await this.mailer.sendSummary(sreq.deviceID, sreq.videoClip);
            }
            
            //await this.mailer.sendSummary(sreq.deviceID, sreq.videoClip);
        });
    }
}
