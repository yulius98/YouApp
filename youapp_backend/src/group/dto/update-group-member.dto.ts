import { IsIn, IsMongoId } from 'class-validator';

export class UpdateGroupMemberDto {
  @IsIn(['add', 'remove'])
  action: 'add' | 'remove';

  @IsMongoId({ message: 'userId harus berupa MongoDB ObjectId yang valid' })
  userId: string;
}
