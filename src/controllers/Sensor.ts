import {Request, Response} from "express";
import Sensor from "../models/Sensor";

const createSensor = async (req: Request, res: Response) => {
    const {name, user} = req.body;
    const newSensor = new Sensor({
        name,
        user,
    });

    return await newSensor
        .save()
        .then(data => {
            {
                res.status(200).json(data);
            }
        })
        .catch(error => {
            {
                res.status(500).json(error);
            }
        });
};

const getSensor = async (req: Request, res: Response) => {
    const {id} = req.params;
    return await Sensor.findById(id)
        .populate('user')
        .then(data => {
            console.log(data);
            data
                ? res.status(200).json(data)
                : res.status(404).send('Sensor not found');
        })

        .catch(error => {
            res.status(500).json(error);
        });
};

const getAllSensors = async (_req: Request, res: Response) => {
    return await Sensor.find()
        .populate('user', 'name lastname email')
        .then(data => {
            res.status(200).json(data);
        })
        .catch(error => {
            res.status(500).json(error);
        });
};

const updateSensor = async (req: Request, res: Response) => {
    const {id} = req.params;
    const {name, user} = req.body;
    return await Sensor.findByIdAndUpdate(
        id,
        {
            name,
            user,
        },
        {new: true},
    )
        .then(data => {
            data
                ? res.status(200).json(data)
                : res.status(404).send('Sensor not found');
        })
        .catch(error => {
            res.status(500).json(error);
        });
};

const deleteSensor = async (req: Request, res: Response) => {
    const {id} = req.params;
    return await Sensor.findByIdAndDelete(id)
        .then(data => {
            data
                ? res.status(200).json(data)
                : res.status(404).send('Sensor not found');
        })
        .catch(error => {
            res.status(500).json(error);
        });
}

export default {
    createSensor,
    getSensor,
    getAllSensors,
    updateSensor,
    deleteSensor
};