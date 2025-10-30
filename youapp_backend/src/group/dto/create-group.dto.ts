import { IsString, IsArray, ArrayNotEmpty, IsMongoId } from 'class-validator';

export class CreateGroupDto {
  @IsString()
  name: string;

  @IsArray()
  @ArrayNotEmpty()
  @IsMongoId({
    each: true,
    message: 'Setiap member harus berupa MongoDB ObjectId yang valid',
  })
  members: string[];
}
