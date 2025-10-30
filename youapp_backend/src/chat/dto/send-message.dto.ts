import { IsMongoId, IsString } from 'class-validator';

export class SendMessageDto {
  @IsMongoId({ message: 'chatId harus berupa MongoDB ObjectId yang valid' })
  chatId: string;

  @IsString()
  content: string;
}
