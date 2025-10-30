import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Message } from '../entities/message.entity';
import { Model } from 'mongoose';
import { RabbitSubscribe } from '@golevelup/nestjs-rabbitmq';

@Injectable()
export class PrivateMessageConsumer {
  constructor(
    @InjectModel(Message.name) private messageModel: Model<Message>,
  ) {}

  @RabbitSubscribe({
    exchange: 'private_chat_exchange',
    routingKey: 'private_chat',
    queue: 'private_chat_queue',
  })
  async handlePrivateMessage(msg: {
    chatId: string;
    senderId: string;
    content: string;
    timestamp?: Date;
  }) {
    await this.messageModel.create({
      chatId: msg.chatId,
      senderId: msg.senderId,
      content: msg.content,
      timestamp: msg.timestamp || new Date(),
    });
  }
}
