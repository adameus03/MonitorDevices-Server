import nodemailer from 'nodemailer';
import winston from 'winston';
//import dotenv from "dotenv";
//dotenv.config();

const logger = winston.createLogger({
    level: 'debug',
    format: winston.format.json(),
    transports: [new winston.transports.Console()]
});

export async function sendMail (from: string, to: string, subject: string, html: string): Promise<void> {
    return new Promise<void>((resolve, reject) => {
        console.log("SEND MAIL (console.log)");
        logger.info("SEND MAIL (winston)");
        console.log(`MAIL_HOST: ${process.env.MAIL_HOST}, MAIL_USERNAME: ${process.env.MAIL_USERNAME}, MAIL_PASSWORD: ${process.env.MAIL_PASSWORD}`);
        const transporter = nodemailer.createTransport({
            service: process.env.MAIL_HOST,
            auth: {
                user: process.env.MAIL_USERNAME,
                pass: process.env.MAIL_PASSWORD
            }
        });

        const mailOptions = {
            from: from,
            to: to,
            subject: subject,
            html: html
        };

        logger.info(`Sending mail to - ${to}`);
        transporter.sendMail(mailOptions, (error, info)=> {
            if (error) {
                //logger.error(error);
                reject(`Error while sending mail: ${error}`);
            } else {
                logger.info('Email sent: ' + info.response);
            }
        });
    });
}

export const getFrom = (): string => {
    return process.env.MAIL_USERNAME??"UNKNOWN";
}