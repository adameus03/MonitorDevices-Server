import { ConnectedDevice, DeviceConnectingServer } from "../device_bridge/app";
import { app, deviceServer} from '../app';
import { EventEmitter } from 'events';
import { AnalyserGlue } from "./analyserGlue";
import { AnalysisResult, AnalysisResultReport } from "./analysisResult";

import db from '../shared/database';
import Persistence from "../modules/persistence/exports/api"
import { clear } from "console";


export class DevbridgeGlue extends EventEmitter {
    static TAG = "DevbrigeGlue";

    // oneFrameSaved = false; // For debugging purpose

    static RECORDING_UNIT_TIME_MS: number = 1000 * 60; // 1 minute  
    static AUTOSAVE_TIMEOUT_MS: number = 1000 * 30; // 30 seconds

    __deviceServer: DeviceConnectingServer
    analyser: AnalyserGlue
    constructor() {
        super();
        this.__deviceServer = deviceServer;
        this.analyser = new AnalyserGlue();
    }

    /** The behaviour of the system is as specified by the following activity UML:
     * @startuml
        partition "Frame reception" {
        (*) --> "Check if recording is set"
        ->if "" then
            ->[is set] "Check if recording threshold time has elapsed"
            if "" then
                --> [not elapsed] "Reset autosave timeout"
                --> "Save frame"
                --> (*)
            else
                ->[elapsed] "Clear autosave timeout"
                --> "Tell the device to stop streaming unconditionally"
                --> "Unset recording"
                --> "Save this frame"
                --> "Convert frames to mp4 video"
                --> "Save the video"
                --> "Notify the user about new video clip"
                --> (*)
            endif
        else
            -->[is not set] "Analyse frame"
            if "" then
                -->[Negative] (*)
            else
                -->[Positive] "Set recording and its start time"
                --> "Notify user about the frame"
                --> "Save the frame"
                --> "Tell the device to stream unconditionally"
                --> "Set timeout for automatic save \nin case device connection is lost"
                --> (*)
            endif
        endif
        }

        partition "Autosave timeout elapsed handling" {
            (*) --> "Try to tell the device to stop streaming unconditionally"
            --> "Unset recording "
            --> "Convert frames to mp4 video"
            
        }
        @enduml
     */
    start() {
        this.__deviceServer.on("deviceConnected", (dev: ConnectedDevice) => {
            console.log(`[${DevbridgeGlue.TAG}] cam connected: ${dev.deviceID}`);

            let autosaveTimer: ReturnType<typeof setTimeout>;

            let autosaveTimeoutHandler = () => {
                // todo Try to tell the device to stop streaming unconditionally
                dev.isRecording = false;
                Persistence.DevStorageManager.transferFramesToVideo(dev.deviceID).then((vidClip) => {
                    console.log(`[${DevbridgeGlue.TAG}] Video clip saved`);
                    this.emit("summaryRequest", {
                        deviceID: dev.deviceID,
                        videoClip: vidClip
                    }); // DONE handle summary notification (send mail with video clip)
                }).catch((err) => {
                    console.error(`[${DevbridgeGlue.TAG}] Error while transferring frames to video: ${err}`);
                });
            };

            dev.videoManager.on("newFrame", async (frameData: Uint8Array) => {
                // Implementation of the UML activity diagram

                if (dev.isRecording) {
                    let recordingElapsedTime = new Date().getTime() - (dev.recordingStartDateTime?.getTime() || 0);
                    if (recordingElapsedTime > DevbridgeGlue.RECORDING_UNIT_TIME_MS) {
                        clearTimeout(autosaveTimer);
                        
                        let analysisResult: AnalysisResult = this.analyser.processFrame(frameData);
                        if (analysisResult.shouldNotify) {
                            console.log('\x1b[31m%s\x1b[0m', `[${DevbridgeGlue.TAG}] Analysis result: should notify`);

                            dev.recordingStartDateTime = new Date(); // Hacky/lazy way to postpone the recording deadline - could be replaced with dev.recordingEndDateTime maybe?

                            autosaveTimer = setTimeout(autosaveTimeoutHandler, DevbridgeGlue.AUTOSAVE_TIMEOUT_MS);

                            await Persistence.DevStorageManager.appendFrame(dev.deviceID, frameData);
                        } else {
                            console.log('\x1b[32m%s\x1b[0m', `[${DevbridgeGlue.TAG}] Analysis result: should not notify`);

                            // TODO Tell the device to stop streaming unconditionally

                            dev.isRecording = false;

                            await Persistence.DevStorageManager.appendFrame(dev.deviceID, frameData);

                            Persistence.DevStorageManager.transferFramesToVideo(dev.deviceID).then((vidClip) => {
                                console.log(`[${DevbridgeGlue.TAG}] Video clip saved`);
                                this.emit("summaryRequest", {
                                    deviceID: dev.deviceID,
                                    videoClip: vidClip
                                }); // DONE handle summary notification (send mail with video clip)
                            }).catch((err) => {
                                console.error(`[${DevbridgeGlue.TAG}] Error while transferring frames to video: ${err}`);
                            });
                        }
                    } else {
                        clearTimeout(autosaveTimer);
                        autosaveTimer = setTimeout(autosaveTimeoutHandler, DevbridgeGlue.AUTOSAVE_TIMEOUT_MS);

                        await Persistence.DevStorageManager.appendFrame(dev.deviceID, frameData);
                    }
                } else {
                    let analysisResult: AnalysisResult = this.analyser.processFrame(frameData);
                    if (analysisResult.shouldNotify) {
                        console.log('\x1b[31m%s\x1b[0m', `[${DevbridgeGlue.TAG}] Analysis result: should notify`);

                        dev.recordingStartDateTime = new Date();
                        dev.isRecording = true;

                        await Persistence.DevStorageManager.appendFrame(dev.deviceID, frameData);
                        
                        let report: AnalysisResultReport = new AnalysisResultReport(dev, frameData, analysisResult);
                        this.emit("notificationRequest", report);
                        
                        // TODO Tell the device to stream unconditionally

                        autosaveTimer = setTimeout(autosaveTimeoutHandler, DevbridgeGlue.AUTOSAVE_TIMEOUT_MS);
                    } else {
                        console.log('\x1b[32m%s\x1b[0m', `[${DevbridgeGlue.TAG}] Analysis result: should not notify`);
                    }
                }

                // // Save the first frame data to a file for debugging
                // // if (!this.oneFrameSaved) {
                // //     const fs = require('fs');
                // //     fs.writeFileSync("/sau/first_framey.jpg", frameData);
                // //     this.oneFrameSaved = true;
                // // }

                // let dbDev = await db.Device.findOne({
                //     where: {
                //         device_id: Buffer.from(dev.deviceID)
                //     }
                // }).catch((err) => {
                //     console.error(`[${DevbridgeGlue.TAG}] Error while querying device from db: ${err}`);
                // });
                
                // // todo Replace this frequent db query with runtime hashmap to offload the database?

                // // If last_notification_datetime is not set, then set it to current time to avoid never notifying
                // let lastNotificationDatetime: string = dbDev?.get('last_notification_datetime') as (string | null) || new Date().toISOString();
                // let shouldAnalyse: boolean = true;
                // let checkingIfStillShouldRecord = false;
                // if (lastNotificationDatetime) {
                //     let lastNotificationDate = new Date(lastNotificationDatetime);
                //     let currentDate = new Date();
                //     let diff = currentDate.getTime() - lastNotificationDate.getTime(); // in milliseconds
                //     console.log(`[${DevbridgeGlue.TAG}] Time since last notification: ${diff} ms`);
                //     if (diff < 1000 * 60) { // 1 minute
                //         shouldAnalyse = false;
                //     } else {
                //         checkingIfStillShouldRecord = true;
                //     }
                // }

                // if (shouldAnalyse) {
                //     let analysisResult: AnalysisResult = this.analyser.processFrame(frameData);
                //     if (analysisResult.shouldNotify) {
                //         console.log('\x1b[31m%s\x1b[0m', `[${DevbridgeGlue.TAG}] Analysis result: should notify`);
                //         let report: AnalysisResultReport = new AnalysisResultReport(dev, frameData, analysisResult);
                //         this.emit("notificationRequest", report);

                //         // Update last_notification_datetime
                //         dbDev?.set('last_notification_datetime', new Date().toISOString());
                //         // Save frame
                //         await Persistence.DevStorageManager.appendFrame(dev.deviceID, frameData);
                //     } else {
                //         console.log('\x1b[32m%s\x1b[0m', `[${DevbridgeGlue.TAG}] Analysis result: should not notify`);
                //         if (checkingIfStillShouldRecord) {
                //             // convert saved frames to video - store the recored video clip
                //             Persistence.DevStorageManager.transferFramesToVideo(dev.deviceID).then((vidClip) => {
                //                 console.log(`[${DevbridgeGlue.TAG}] Video clip saved`);
                //                 this.emit("summaryRequest", {
                //                     deviceID: dev.deviceID,
                //                     videoClip: vidClip
                //                 }); // DONE handle summary notification (send mail with video clip)
                //             }).catch((err) => {
                //                 console.error(`[${DevbridgeGlue.TAG}] Error while transferring frames to video: ${err}`);
                //             });
                //         }
                //     }

                // } else {
                //     // Save frame
                //     await Persistence.DevStorageManager.appendFrame(dev.deviceID, frameData);
                // }


                
            });
        });
        this.__deviceServer.on("deviceDisconnected", (dev: ConnectedDevice) => {
            console.log(`[${DevbridgeGlue.TAG}] cam disconnected: ${dev.deviceID}`);
        });
    }
}
