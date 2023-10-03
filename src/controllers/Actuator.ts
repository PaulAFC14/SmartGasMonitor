import {Request, Response} from 'express';
import Actuator from '../models/Actuator';

const createActuator = async (req: Request, res: Response) => {
  const {name, state, user} = req.body;
  const newActuator = new Actuator({
    name,
    state,
    user,
  });

  return await newActuator
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

const getActuator = async (req: Request, res: Response) => {
  const {id} = req.params;
  return await Actuator.findById(id)
    .populate('user')
    .then(data => {
      console.log(data);
      data
        ? res.status(200).json(data)
        : res.status(404).send('Actuator not found');
    })

    .catch(error => {
      res.status(500).json(error);
    });
};

const getAllActuators = async (_req: Request, res: Response) => {
  return await Actuator.find()
    .populate('user', 'name lastname email')
    .then(data => {
      res.status(200).json(data);
    })
    .catch(error => {
      res.status(500).json(error);
    });
};

const updateActuator = async (req: Request, res: Response) => {
  const {id} = req.params;
  const {name, state, user} = req.body;
  return await Actuator.findByIdAndUpdate(
    id,
    {
      name,
      state,
      user,
    },
    {new: true},
  )
    .then(data => {
      data
        ? res.status(200).json(data)
        : res.status(404).send('Actuator not found');
    })
    .catch(error => {
      res.status(500).json(error);
    });
};

const deleteActuator = async (req: Request, res: Response) => {
  const {id} = req.params;
  return await Actuator.findByIdAndRemove(id)
    .then(data => {
      data
        ? res.status(200).json(data)
        : res.status(404).send('Actuator not found');
    })
    .catch(error => {
      res.status(500).json(error);
    });
};

export default {
  createActuator,
  getActuator,
  getAllActuators,
  updateActuator,
  deleteActuator,
};
