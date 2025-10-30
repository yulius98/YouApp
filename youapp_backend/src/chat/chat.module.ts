import { Module } from '@nestjs/common';
import { ChatGateway } from './chat.gateway';
import { ChatController } from './chat.controller';
import { ChatService } from './chat.service';
import { MongooseModule } from '@nestjs/mongoose';
import { Message, MessageSchema } from './entities/message.entity';
import { ChatMessage, ChatMessageSchema } from './entities/chat-message.schema';
import { Chat, ChatSchema } from './entities/chat.entity';
import { AuthModule } from '../auth/auth.module';
import { PrivateMessageConsumer } from './consumers/private-message.consumer';
import { RabbitMQModule } from '@golevelup/nestjs-rabbitmq';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: Message.name, schema: MessageSchema },
      { name: ChatMessage.name, schema: ChatMessageSchema },
      { name: Chat.name, schema: ChatSchema },
    ]),
    AuthModule,
    RabbitMQModule.forRoot({
      exchanges: [
        {
          name: 'private_chat_exchange',
          type: 'topic',
        },
      ],
      uri: process.env.RABBITMQ_URI || 'amqp://localhost:5672',
    }),
  ],
  controllers: [ChatController],
  providers: [ChatGateway, ChatService, PrivateMessageConsumer],
})
export class ChatModule {}
