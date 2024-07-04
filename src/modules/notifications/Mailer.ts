import { AnalysisResultReport } from "../../analyser_bridge/analysisResult";
import { ConnectedDevice } from "../../device_bridge/app";
import { NotificationExecutor } from "./NotificationExecutor";

import { sendMail, getFrom } from "./mailService";

import db from "../../shared/database";

import { uint8ArrayToBase64Url } from "./utils"
import { VideoClip } from "../persistence/VideoClip";

export class Mailer implements NotificationExecutor {
    static TAG = "Mailer";

    async send(report: AnalysisResultReport) {
        console.log('\x1b[31m\x1b[46m%s\x1b[0m', `[${Mailer.TAG}] In Mailer.send`);

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
        let cameraName: string = dev?.get('name') as string;
        
        const from: string = getFrom();
        const to: string = devOwner?.get('email') as string;
        const subject: string = `Camera notification (${cameraName})`;
        const mailContent: string = `Hello, your camera "${cameraName}" has detected a person in the frame. Please check the camera feed. 
        <br><img src="${uint8ArrayToBase64Url(report.frameData)}">`;

        sendMail( from, to, subject, mailContent).then(() => {
            console.log(`[${Mailer.TAG}] Mail with a frame sent to ${to}`);
        }).catch((err) => {
            console.warn(`[${Mailer.TAG}] Error while sending frame-mail: ${err}`);
        });
    }

    async sendSummary(devID: string, videoClip: VideoClip) {
        console.log('\x1b[31m\x1b[45m%s\x1b[0m', `[${Mailer.TAG}] In Mailer.sendSummary, vkey=${videoClip.vkey}`);
        let dev = await db.Device.findOne({
            where: {
                device_id: Buffer.from(devID)
            }
        });
        let devOwner = await db.User.findOne({
            where: {
                user_id: dev?.get('user_id')
            }
        });
        let cameraName: string = dev?.get('name') as string;
        
        const from: string = getFrom();
        const to: string = devOwner?.get('email') as string;
        const subject: string = `Camera notification (${cameraName})`;

        let videoPath: string = VideoClip.getApiUrlExternal(videoClip.clip_id, videoClip.vkey);

        const mailContent: string = `Hello, we have registered suspicious activity on your camera "${cameraName}". Please check the video clip below. 
            <br><video width="320" height="240" controls>
                <source src="${videoPath}" type="video/mp4">
                Your browser does not support the video tag.
            </video><br>Yours, the camera team. <i>PS: You can also view and download the video clip <a href="${videoPath}">here</a>. WARNING: If you share this link, anyone with the link will be able to view the video.</i>`;

        sendMail( from, to, subject, mailContent).then(() => {
            console.log(`[${Mailer.TAG}] Mail with a video sent to ${to}`);
        }).catch((err) => {
            console.error(`[${Mailer.TAG}] Error while sending video-mail: ${err}`);
        });
    }
}
