import { existsSync, mkdirSync, unlinkSync, writeFileSync } from 'fs';
import { get } from 'http';
import { FrameTimestampHelper } from './FrameTimestampHelper';
import { VideoClip } from './VideoClip';

import db from '../../shared/database';

const { exec } = require('child_process');


/** 
 * Manages the storage of frames sent by the devices
*/
export class DevStorageManager {
    static TAG = "DevStorageManager";

    /* Map device ID to the number of frames in the device frames directory */
    private frameCounterHashmap = new Map<Uint8Array, number>();

    public getDevDirectory(devID: Uint8Array): string {
        return `${process.env.DEVFILES_LOCATION}/${devID}`;
    }

    public getDevFramesDirectory(devID: Uint8Array): string {
        return `${this.getDevDirectory(devID)}/frames`;
    }

    public getDevVideosDirectory(devID: Uint8Array): string {
        return `${this.getDevDirectory(devID)}/videos`;
    }

    public getDevFrame(devID: Uint8Array, frameNumber: number): string {
        return `${this.getDevFramesDirectory(devID)}/${frameNumber}.jpg`;
    }

    public async getDevVideoPathAsync(clipID: string): Promise<string> {
        let videoClip = await db.VideoClip.findOne({
            where: {
                clip_id: clipID
            }
        }).catch((err) => {
            throw new Error(`Error while querying video clip from db: ${err}`);
        });

        //let videosDir = this.getDevVideosDirectory(videoClip?.get('device_id') as Uint8Array);
        //let videosDir = this.getDevVideosDirectory(Buffer.from(videoClip?.get('device_id') as Uint8Array));
        let videosDir = this.getDevVideosDirectory(new Uint8Array(videoClip?.get('device_id') as Buffer));
        console.log(`[${DevStorageManager.TAG}] videosDir: ${videosDir}`);
        let videoName = `${clipID}.mp4`;
        let videoPath = `${videosDir}/${videoName}`;
        
        return videoPath;
    }

    /**
        @note Parent directory path is stored in the environment variable DEVFILES_LOCATION
        @note The device directory will be named after the device ID and placed at $DEVFILES_LOCATION/devID
        @note The device directory will contain the following subdirectories:
                frames: Contains the frames sent by the device before combining them into a video file
                videos: Contains the video files generated from the frames. After the video is generated, the frames are deleted
    */
    public createDevDirectory(devID: Uint8Array): void {
        // Create the device directory
        const devDir = this.getDevDirectory(devID);
        if (!existsSync(devDir)) {
            mkdirSync(devDir);
        } else {
            throw new Error(`Device directory ${devDir} already exists`);
        }

        // Create the frames and videos subdirectories

        const framesDir = this.getDevFramesDirectory(devID);
        mkdirSync(framesDir);

        const videosDir = this.getDevVideosDirectory(devID);
        mkdirSync(videosDir);
    }

    /**
     * 
     * @param devID 16-byte device ID
     * @param frameData JFIF frame data
     * @returns Number of frames in the device frames directory
     */
    public appendFrame(devID: Uint8Array, frameData: Uint8Array, renderTimestamp=true): Promise<number> {
        return new Promise((resolve, reject) => {
            const framesDir = this.getDevFramesDirectory(devID);

            // Check if the frame counter hashmap has an entry for this device. If not, create one with a value calculated from the number of frames in the frames directory
            if (!this.frameCounterHashmap.has(devID)) {
                const frameFiles = require('fs').readdirSync(framesDir);
                this.frameCounterHashmap.set(devID, frameFiles.length);
            }

            // Create the frame file using the frame counter as the filename
            const frameCounter = this.frameCounterHashmap.get(devID) || 0;
            const framePath = this.getDevFrame(devID, frameCounter);

            // Increment the frame counter
            this.frameCounterHashmap.set(devID, frameCounter + 1);

            if (renderTimestamp) {
                // Append the timestamp to the frame data
                const timestamp: string = new Date().toISOString();
                // Modify frameData so that it represents the frame with timestamp rendered on it
                const frameTimestampHelper: FrameTimestampHelper = new FrameTimestampHelper(timestamp, frameData);
                frameTimestampHelper.getTimestampedFrameData().then((timestampedFrameData: Uint8Array) => {
                    // Write the frame data to the file
                    writeFileSync(framePath, timestampedFrameData);

                    resolve(frameCounter);
                }).catch((err: any) => {
                    console.error(`Error rendering timestamp on frame: ${err}`);
                });
            } else {
                // Write the frame data to the file
                writeFileSync(framePath, frameData);

                resolve(frameCounter);
            }
        });
    }

    /**
     * Combines the frames in the device frames directory into a video file and deletes the hanging frames
     * If there are no frames in the device frames directory, this function does nothing and the promise resolves with null
     * Otherwise the output video vkey will be returned via promise resolution
     * @param devID 16-byte device ID
     */
    public transferFramesToVideo(devID: Uint8Array): Promise<VideoClip | null> {
        console.log('\x1b[31m\x1b[44m%s\x1b[0m', `${DevStorageManager.TAG} In transferFramesToVideo for device ${devID}`);
        return new Promise(async (resolve, reject) => {
            const framesDir = this.getDevFramesDirectory(devID);
            const videosDir = this.getDevVideosDirectory(devID);
            const frameCounter = this.frameCounterHashmap.get(devID) || 0;

            if (frameCounter < 1) {
                console.log(`No frames to combine into video for device ${devID}`);
                resolve(null);
            }

            // Combine the frames into a video file
            // @todo Implement this
            // ffmpeg -framerate 1 -i frame%d.jpg -c:v libx264 -r 30 -pix_fmt yuv420p out.mp4

            let videoClip: VideoClip = await VideoClip.create(devID);

            // Name the video as video_clip_id.mp4
            const videoName = `${videoClip.clip_id}.mp4`;
            //const videoName = `video_${new Date().toISOString().replace(/[-:]/g, '').replace('T', '_').slice(0, 15)}.mp4`;
            const videoPath = `${videosDir}/${videoName}`;

            // Combine the frames into a video file
            exec(`ffmpeg -framerate 10 -i ${framesDir}/%d.jpg -c:v libx264 -r 10 -pix_fmt yuv420p ${videoPath}`, async (error: any, stdout: any, stderr: any) => {
                if (error) {
                    console.error(`exec error: ${error}`);
                    return;
                }
                
                // If ffmpeg command is successful, delete the frames and reset the frame counter, else throw an error
                //if (!stderr) {

                for (let i = 0; i < frameCounter; i++) {
                    const framePath = this.getDevFrame(devID, i);
                    if (existsSync(framePath)) {
                        unlinkSync(framePath);
                    }
                }
        
                this.frameCounterHashmap.set(devID, 0);
                console.log(`Frames combined into video: ${videoPath}`);
                resolve(videoClip);
                //} else {
                //    reject(`Error combining frames into video: ${stderr}`);
                //}

            });
        });
    }

    /**
     * Deletes all frames in the device frames directory
     * @param devID 16-byte device ID
     */
    public clearFrames(devID: Uint8Array): void {
        const framesDir = this.getDevFramesDirectory(devID);
        const frameCounter = this.frameCounterHashmap.get(devID) || -1;

        for (let i = 0; i < frameCounter; i++) {
            const framePath = this.getDevFrame(devID, i);
            if (existsSync(framePath)) {
                unlinkSync(framePath);
            }
        }

        this.frameCounterHashmap.set(devID, 0);
    }

    /**
     * Deletes the device directory and all its contents
     * @param devID 16-byte device ID
     */
    public deleteDevDirectory(devID: Uint8Array): void {
        const devDir = this.getDevDirectory(devID);

        // Delete the device directory
        unlinkSync(devDir);
    }

    private static _instance: DevStorageManager
    private static _MAGIC_NUMBER: number = 42069
    public static getInstance(): DevStorageManager {
        if (!this._instance) {
            this._instance = new DevStorageManager(this._MAGIC_NUMBER)
        }
        return this._instance;
    }

    /**
     * Don't use the constructor to instantiate this class. Use DevStorageManager.getInstance() instead
     * @param magicNumber Magic number to prevent accidental instantiation of this class using the constructor
     */
    constructor(magicNumber: number) {
        if (magicNumber !== DevStorageManager._MAGIC_NUMBER) {
            throw new Error("Use DevStorageManager.getInstance() to get the singleton instance");
        }
    }

}

export default DevStorageManager.getInstance(); // Singleton instance
