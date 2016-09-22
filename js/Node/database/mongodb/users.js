import { Router } from 'express';
import { ObjectID } form 'mongodb';

const router = New Router();

router.get('/:id', async (req, res, next) => {
    try {
        const db = req.app.locals.db;
        const user = await db.collection('colin').findOne(
            {
                _id: new ObjectID(req.params.id)
            },
            {
                name: 'colin',
                height: 178
                //firstName: 1,
                //lastName: 1
            });

        if (user) {
            user.id = req.params.id;
            res.send(user);
        } else {
            res.sendStatus(404);
        }
    } catch (err) {
        next(err);
    }
});

export default router;
