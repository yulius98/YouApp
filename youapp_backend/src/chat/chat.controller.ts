import {
  Controller,
  Post,
  Body,
  Get,
  Param,
  Query,
  Delete,
  UseGuards,
} from '@nestjs/common';
import { ChatService } from './chat.service';
import { CreatePrivateChatDto } from './dto/create-private-chat.dto';
import { SendMessageDto } from './dto/send-message.dto';
import { GetUser } from '../common/decorators/get-user.decorator';
import { JwtAuthGuard } from '../common/guards/jwt-auth.guard';

@Controller('api/chats')
@UseGuards(JwtAuthGuard)
export class ChatController {
  constructor(private readonly chatService: ChatService) {}

  @Post('private')
  async createOrGetPrivateChat(
    @Body() dto: CreatePrivateChatDto,
    @GetUser() user: { _id: string; email: string },
  ) {
    const userId = user._id;
    return this.chatService.createOrGetPrivateChat(userId, dto.userId);
  }

  @Post('sendMessage')
  async sendMessage(
    @Body() dto: SendMessageDto,
    @GetUser() user: { _id: string; email: string },
  ) {
    const senderId = user._id;
    return this.chatService.sendMessage(senderId, dto);
  }

  @Get(':userId/viewMessage')
  async getPrivateChatHistory(
    @Param('userId') userId: string,
    @GetUser() user: { _id: string; email: string },
    @Query('page') page = 1,
    @Query('limit') limit = 10,
    @Query('since') since?: string,
  ) {
    const currentUserId = user._id;
    const messages = await this.chatService.getPrivateChatHistory(
      currentUserId,
      userId,
      {
        page: +page,
        limit: +limit,
        since,
      },
    );
    if (!messages || messages.length === 0) {
      return {
        status: false,
        message: 'Chat history data not found',
      };
    }
    return messages;
  }

  @Get()
  async getAllPrivateChats(@GetUser() user: { _id: string; email: string }) {
    const userId = user._id;
    return this.chatService.getAllPrivateChats(userId);
  }

  @Delete(':chatId/deleteChat')
  async deletePrivateChat(
    @Param('chatId') chatId: string,
    @GetUser() user: { _id: string; email: string },
  ) {
    const result = await this.chatService.deletePrivateChat(chatId, user._id);
    if (!result || result.deletedCount === 0) {
      return {
        success: false,
        Idchat: chatId,
        message: 'chat not found',
      };
    }
    return {
      success: true,
      Idchat: chatId,
      message: 'chat already delete',
    };
  }
}
