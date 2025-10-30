import {
  Controller,
  Post,
  Body,
  UseGuards,
  Get,
  Param,
  Query,
} from '@nestjs/common';
import { JwtAuthGuard } from '../common/guards/jwt-auth.guard';
import { ChatService } from './chat.service';
import { CreatePrivateChatDto } from './dto/create-private-chat.dto';
import { SendMessageDto } from './dto/send-message.dto';
import { GetUser } from '../common/decorators/get-user.decorator';

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
    return this.chatService.getPrivateChatHistory(currentUserId, userId, {
      page: +page,
      limit: +limit,
      since,
    });
  }

  @Get()
  async getAllPrivateChats(@GetUser() user: { _id: string; email: string }) {
    const userId = user._id;
    return this.chatService.getAllPrivateChats(userId);
  }
}
