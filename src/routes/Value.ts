import express from 'express';
import controller from '../controllers/Value';
const router = express.Router();

router.post('/create', controller.createValue);
router.get('/get/:id', controller.getValue);
router.get('/get', controller.getAllValues);
router.put('/update/:id', controller.updateValue);
router.delete('/delete/:id', controller.deleteValue);

export default router;