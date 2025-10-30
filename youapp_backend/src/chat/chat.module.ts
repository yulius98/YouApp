import { Module } from '@nestjs/common';
import { ChatGateway } from './chat.gateway';
import { ChatService } from './chat.service';
import { MongooseModule } from '@nestjs/mongoose';
import { Message, MessageSchema } from './entities/message.entity';
import { ChatMessage, ChatMessageSchema } from './entities/chat-message.schema';
import { AuthModule } from '../auth/auth.module'; // Untuk auth di gateway jika perlu

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: Message.name, schema: MessageSchema },
      { name: ChatMessage.name, schema: ChatMessageSchema },
    ]),
    AuthModule,
  ],
  providers: [ChatGateway, ChatService],
})
export class ChatModule {}
