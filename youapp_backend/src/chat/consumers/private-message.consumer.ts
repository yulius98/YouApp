import { Injectable } from '@nestjs/common';
import { ChatGateway } from '../chat.gateway';
import { InjectModel } from '@nestjs/mongoose';
import { Message } from '../entities/message.entity';
import { Model } from 'mongoose';
import { RabbitSubscribe } from '@golevelup/nestjs-rabbitmq';

@Injectable()
export class PrivateMessageConsumer {
  constructor(
    @InjectModel(Message.name) private messageModel: Model<Message>,
    private readonly chatGateway: ChatGateway,
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
    const saved = await this.messageModel.create({
      chatId: msg.chatId,
      userId: msg.senderId,
      content: msg.content,
      createdAt: msg.timestamp || new Date(),
    });
    // Emit ke client lawan bicara via gateway
    this.chatGateway.server.emit('private_message', saved);
  }
}
