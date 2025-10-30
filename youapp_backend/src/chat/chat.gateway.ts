import {
  WebSocketGateway,
  SubscribeMessage,
  MessageBody,
  ConnectedSocket,
  WsException,
} from '@nestjs/websockets';
import { Socket } from 'socket.io';
import { ChatService } from './chat.service';
import { MessageDto } from './dto/message.dto';

@WebSocketGateway({ cors: true })
export class ChatGateway {
  constructor(private chatService: ChatService) {}

  @SubscribeMessage('message')
  async handleMessage(
    @ConnectedSocket() client: Socket,
    @MessageBody() messageDto: MessageDto,
  ) {
    if (!messageDto.content) throw new WsException('Invalid message');
    const message = await this.chatService.create(messageDto);
    client.broadcast.emit('message', message); // Broadcast to all
    return message;
  }
}
