import mongoose, {Schema, Document} from 'mongoose';

export interface IActuator {
  name: string;
  state: boolean;
  user: string;
}
export interface IActuatorModel extends IActuator, Document {}
const ActuatorSchema: Schema = new Schema(
  {
    name: {type: String, required: true},
    state: {type: Boolean, required: true},
    user: {
      type: Schema.Types.ObjectId,
      required: true,
      ref: 'User',
    },
  },
  {versionKey: false, timestamps: true},
);

export default mongoose.model<IActuatorModel>('Actuator', ActuatorSchema);
