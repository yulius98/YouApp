import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

@Schema({ timestamps: true })
export class Message extends Document {
  @Prop({ required: true })
  content: string;

  @Prop({ required: true })
  userId: string;

  @Prop()
  chatId?: string;

  @Prop()
  createdAt?: Date;
}

export const MessageSchema = SchemaFactory.createForClass(Message);
