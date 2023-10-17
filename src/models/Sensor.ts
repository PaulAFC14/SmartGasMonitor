import mongoose, {Schema, Document} from 'mongoose';

export interface ISensor {
  name: string;
  user: string;
}

export interface ISensorModel extends ISensor, Document {}
const SensorSchema: Schema = new Schema(
    {
        name: {type: String, required: true},
        user: {
            type: Schema.Types.ObjectId,
            required: true,
            ref: 'User',
        },
    },
    {versionKey: false, timestamps: true},
);

export default mongoose.model<ISensorModel>('Sensor', SensorSchema);