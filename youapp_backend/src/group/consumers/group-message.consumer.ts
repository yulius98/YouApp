import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { GroupMessage } from '../entities/group-message.entity';
import { Model } from 'mongoose';
import { RabbitSubscribe } from '@golevelup/nestjs-rabbitmq';

@Injectable()
export class GroupMessageConsumer {
  constructor(
    @InjectModel(GroupMessage.name)
    private groupMessageModel: Model<GroupMessage>,
  ) {}

  @RabbitSubscribe({
    exchange: 'group_chat_exchange',
    routingKey: 'group_chat',
    queue: 'group_chat_queue',
  })
  async handleGroupMessage(msg: any) {
    await this.groupMessageModel.create({
      groupId: msg.groupId,
      senderId: msg.senderId,
      content: msg.content,
      timestamp: msg.timestamp || new Date(),
    });
  }
}
