import {Request, Response} from 'express';
import Value from '../models/Value';

const createValue = async (req: Request, res: Response) => {
    const {gas, temp, date, sensor} = req.body;
    const newValue = new Value({
        gas,
        temp,
        date,
        sensor,
    });
    
    return await newValue
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

const getValue = async (req: Request, res: Response) => {
    const {id} = req.params;
    return await Value.findById(id)
        .populate('sensor')
        .then(data => {
            console.log(data);
            data
                ? res.status(200).json(data)
                : res.status(404).send('Value not found');
        })
        .catch(error => {
            res.status(500).json(error);
        });
};

const getAllValues = async (_req: Request, res: Response) => {
    return await Value.find()
        .populate('sensor', 'name')
        .then(data => {
            res.status(200).json(data);
        })
        .catch(error => {
            res.status(500).json(error);
        });
};

const updateValue = async (req: Request, res: Response) => {
    const {id} = req.params;
    const {gas, temp, date, sensor} = req.body;
    return await Value.findByIdAndUpdate(
        id,
        {
            gas,
            temp,
            date,
            sensor,
        },
        {new: true},
    )
        .then(data => {
            res.status(200).json(data);
        })
        .catch(error => {
            res.status(500).json(error);
        });
};

const deleteValue = async (req: Request, res: Response) => {
    const {id} = req.params;
    return await Value.findByIdAndRemove(id)
        .then(data => {
            res.status(200).json(data);
        })
        .catch(error => {
            res.status(500).json(error);
        });
};

export default {
    createValue,
    getValue,
    getAllValues,
    updateValue,
    deleteValue,
}