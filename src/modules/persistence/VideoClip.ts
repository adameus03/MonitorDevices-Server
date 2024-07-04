import db from '../../shared/database';

import CryptoJS from 'crypto-js';

// CRUD utilities for video clips + vkey hashing
export class VideoClip {
    public clip_id: number;
    public vkey: string;

    constructor(clip_id: number, vkey: string) {
        this.clip_id = clip_id;
        this.vkey = vkey;
    }


    static async create(device_id: Uint8Array): Promise<VideoClip> {
        let vkey = Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15); // 30 char random string
        let vkey_hash = CryptoJS.SHA256(vkey).toString();
        try {
            let videoClip = await db.VideoClip.create({
                device_id: Buffer.from(device_id),
                vkey_hash: vkey_hash,
                save_timestamp: new Date()
            });
            return new VideoClip(
                videoClip.get('clip_id') as number, 
                vkey
            );
        } catch (error) {
            console.log(error);
            throw error;
        }
    }

    static getApiUrl(clip_id: number, vkey: string): string {
        return `/video/${clip_id}?vkey=${vkey}`;
    }

    static getApiUrlExternal(clip_id: number, vkey: string): string {
        return `https://127.0.0.1:8090${VideoClip.getApiUrl(clip_id, vkey)}`;
    }
}
