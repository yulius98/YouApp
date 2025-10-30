import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { GroupController } from './group.controller';
import { GroupService } from './group.service.js';
import { Group, GroupSchema } from './entities/group.entity';
import {
  GroupMessage,
  GroupMessageSchema,
} from './entities/group-message.entity';
import { AmqpConnection, RabbitMQModule } from '@golevelup/nestjs-rabbitmq';
import { GroupMessageConsumer } from './consumers/group-message.consumer';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: Group.name, schema: GroupSchema },
      { name: GroupMessage.name, schema: GroupMessageSchema },
    ]),
    RabbitMQModule.forRoot({
      exchanges: [
        {
          name: 'group_chat_exchange',
          type: 'topic',
        },
      ],
      uri: process.env.RABBITMQ_URI || 'amqp://localhost:5672',
    }),
  ],
  controllers: [GroupController],
  providers: [GroupService, AmqpConnection, GroupMessageConsumer],
  exports: [GroupService],
})
export class GroupModule {}
