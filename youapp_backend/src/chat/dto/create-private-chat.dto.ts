import { IsMongoId } from 'class-validator';

export class CreatePrivateChatDto {
  @IsMongoId({ message: 'userId harus berupa MongoDB ObjectId yang valid' })
  userId: string;
}
