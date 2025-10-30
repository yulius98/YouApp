import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Message } from './entities/message.entity';
import { ChatMessage } from './entities/chat-message.schema';
import { MessageDto } from './dto/message.dto';
import { Chat } from './entities/chat.entity';
import { SendMessageDto } from './dto/send-message.dto';
import { AmqpConnection } from '@golevelup/nestjs-rabbitmq';

@Injectable()
export class ChatService {
  constructor(
    @InjectModel(Message.name) private messageModel: Model<Message>,
    @InjectModel(ChatMessage.name) private chatMessageModel: Model<ChatMessage>,
    @InjectModel(Chat.name) private chatModel: Model<Chat>,
    private readonly amqpConnection: AmqpConnection,
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

  async createOrGetPrivateChat(
    userId: string,
    otherUserId: string,
  ): Promise<Chat> {
    // Find existing chat between the two users
    const existingChat = await this.chatModel
      .findOne({
        participants: { $all: [userId, otherUserId], $size: 2 },
      })
      .exec();

    if (existingChat) {
      return existingChat;
    }

    // Create new chat if none exists
    const newChat = new this.chatModel({
      participants: [userId, otherUserId],
    });
    return newChat.save();
  }

  async sendMessage(senderId: string, dto: SendMessageDto): Promise<Message> {
    const message = new this.messageModel({
      content: dto.content,
      userId: senderId,
      chatId: dto.chatId,
      timestamp: new Date(),
    });
    const savedMessage = await message.save();

    // Publish ke RabbitMQ agar lawan bicara menerima pesan

    const msgObj = savedMessage.toObject
      ? savedMessage.toObject()
      : savedMessage;
    await this.amqpConnection.publish('private_chat_exchange', 'private_chat', {
      chatId: dto.chatId,
      senderId,
      content: dto.content,
      timestamp: msgObj && msgObj.createdAt ? msgObj.createdAt : new Date(),
    });

    return savedMessage;
  }

  async getPrivateChatHistory(
    currentUserId: string,
    otherUserId: string,
    options: { page: number; limit: number; since?: string },
  ): Promise<Message[]> {
    const query: { userId: { $in: string[] }; createdAt?: { $gt: Date } } = {
      userId: { $in: [currentUserId, otherUserId] },
    };

    if (options.since) {
      query.createdAt = { $gt: new Date(options.since) };
    }

    const messages = await this.messageModel
      .find(query)
      .sort({ createdAt: -1 })
      .skip((options.page - 1) * options.limit)
      .limit(options.limit)
      .exec();

    return messages.reverse();
  }

  async getAllPrivateChats(userId: string): Promise<Chat[]> {
    return this.chatModel
      .find({
        participants: userId,
      })
      .exec();
  }
}
