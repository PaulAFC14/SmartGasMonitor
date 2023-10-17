import express from 'express';
import controller from '../controllers/Sensor';
const router = express.Router();

router.post('/create', controller.createSensor);
router.get('/get/:id', controller.getSensor);
router.get('/get', controller.getAllSensors);
router.put('/update/:id', controller.updateSensor);
router.delete('/delete/:id', controller.deleteSensor);

export default router;