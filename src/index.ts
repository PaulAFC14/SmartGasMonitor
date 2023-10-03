import express from 'express';
import mongoose from 'mongoose';
import {config} from './config/config';
import UserRoutes from './routes/User';
import ActuatorRoutes from './routes/Actuator';

const PORT = 3000;
const app = express();

app.use(express.json());
app.use(express.urlencoded({extended: true}));

mongoose
  .connect(config.mongo.url, {retryWrites: true, w: 'majority'})
  .then(() => {
    console.log('Connected to MongoDB');
  })
  .catch(error => {
    console.log('Error connecting to MongoDB', error.message);
  });

app.use('/user', UserRoutes);
app.use('/actuator', ActuatorRoutes);

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
