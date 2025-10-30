import { IsString } from 'class-validator';

export class SendGroupMessageDto {
  @IsString()
  content: string;
}
