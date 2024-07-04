// Import the jimp library - for image manipulation
import Jimp from 'jimp';

export class FrameTimestampHelper {
    timestamp: string;
    frameData: Uint8Array;
    
    constructor(timestamp: string, frameData: Uint8Array) {
        this.timestamp = timestamp;
        this.frameData = frameData;
    }

    getTimestampedFrameData(): Promise<Uint8Array> {
        // Load the frame data into a Jimp image
        return new Promise((resolve, reject) => {
            Jimp.read(Buffer.from(this.frameData)).then(async image => {
                // Add the timestamp to the image
                image.print(await Jimp.loadFont(Jimp.FONT_SANS_16_WHITE), 0, 0, this.timestamp);
                // Convert the image to a buffer
                image.getBuffer(Jimp.MIME_JPEG, (err, buffer) => {
                    if (err) {
                        reject(err);
                    } else {
                        resolve(buffer);
                    }
                });
            }).catch(err => {
                reject(err);
            });
        });
    }

}
