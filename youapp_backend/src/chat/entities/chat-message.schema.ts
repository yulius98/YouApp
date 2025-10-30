import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

@Schema()
export class ChatMessage extends Document {
  @Prop({ required: true })
  username: string;

  @Prop({ required: true })
  date_time: Date;

  @Prop({ required: true })
  chat: string;
}

export const ChatMessageSchema = SchemaFactory.createForClass(ChatMessage);
