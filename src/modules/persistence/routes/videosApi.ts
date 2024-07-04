import express from 'express';
import createError from 'http-errors';
import CryptoJS from 'crypto-js';
import { StatusCodes } from 'http-status-codes';

import db from '../../../shared/database';

import Persistence from '../exports/api';

const router = express.Router();

// Serve video file by clip ID. Use a long vkey (get parameter) to prevent unauthorized access (compare with the vkey hash in the database)
router.get('/video/:clip_id', async (req, res, next) => {
    const clip_id = req.params.clip_id;
    const vkey: string = req.query.vkey?.toString() || '';

    if (!clip_id || !vkey) {
        return res.status(StatusCodes.BAD_REQUEST).json({ error: 'Clip ID or vkey missing' });
    }

    let vkeyHash_userProvided = CryptoJS.SHA256(vkey).toString();

    try {
        const clip = await db.VideoClip.findOne({
            where: {
                clip_id: clip_id,
                vkey_hash: vkeyHash_userProvided
            }
        });

        if (!clip) {
            return res.status(StatusCodes.NOT_FOUND).json({ error: 'Clip not found' });
        }

        let videoPath: string = await Persistence.DevStorageManager.getDevVideoPathAsync(clip_id);
        console.log("Path of video that will be returned by the videosApi: " + videoPath);
        
        // Send the video file using express
        res.sendFile(videoPath);
    } catch (error) {
        return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({ error: 'Internal server error' });
    }
});

export default {
    router: router
}