import moongose, { Schema, Document } from 'mongoose';

export interface IValue {
    gas : number;
    temp : number;
    date : Date;
    sensor : string;
}

export interface IValueModel extends IValue, Document {}
const ValueSchema : Schema = new Schema(
    {
        gas : { type : Number, required : true },
        temp : { type : Number, required : true },
        date : { type : Date, required : true },
        sensor : {
            type : Schema.Types.ObjectId,
            required : true,
            ref : 'Sensor',
        },
    },
    { versionKey : false, timestamps : true },
);

export default moongose.model<IValueModel>('Value', ValueSchema);