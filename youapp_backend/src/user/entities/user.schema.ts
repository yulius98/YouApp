import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

@Schema()
export class User extends Document {
  @Prop({ required: true })
  name: string;

  @Prop({ required: true, unique: true })
  username: string;

  @Prop({ required: true, unique: true })
  email: string;

  @Prop({ required: true })
  password: string;

  @Prop()
  birthday: string;

  @Prop()
  height: number;

  @Prop()
  weight: number;

  @Prop({ type: [String] })
  interests: string[];

  @Prop()
  horoscope: string;

  @Prop()
  zodiac: string;
}

export const UserSchema = SchemaFactory.createForClass(User);
