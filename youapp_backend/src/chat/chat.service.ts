import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Message } from './entities/message.entity';
import { ChatMessage } from './entities/chat-message.schema';
import { MessageDto } from './dto/message.dto';

@Injectable()
export class ChatService {
  constructor(
    @InjectModel(Message.name) private messageModel: Model<Message>,
    @InjectModel(ChatMessage.name) private chatMessageModel: Model<ChatMessage>,
  ) {}
  // CRUD for chat_message collection
  async createChatMessage(data: Partial<ChatMessage>): Promise<ChatMessage> {
    const chatMsg = new this.chatMessageModel(data);
    return chatMsg.save();
  }

  async findAllChatMessages(): Promise<ChatMessage[]> {
    return this.chatMessageModel.find().exec();
  }

  async create(messageDto: MessageDto): Promise<Message> {
    const message = new this.messageModel(messageDto);
    return message.save();
  }

  async findAll(): Promise<Message[]> {
    return this.messageModel.find().exec();
  }
}
