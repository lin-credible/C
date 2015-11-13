import express from 'express';
import Promise from 'bluebird';
import logger from 'winston';
import { MongoClient } from 'mongodb';
import config from './config';

const PORT = process.env.PORT || 3000;
const server = express();

server.use('/api/users', require('./users'));

server.get('/', (req, res) => {
    res.send('Hello World');
});

MongoClient.connect(config.database.url, { promiseLibrary: Promise }, (err, db) => {
    if (err) {
        logger.warn(`Failed to connect to the database. ${err.stack}`);
    }
    server.locals.db = db;
    server.listen(PORT, () => {
        const { address, port } = server.address();
        logger.info(`Node.js server is listening at http://${address}:${port}`);
    });
});
