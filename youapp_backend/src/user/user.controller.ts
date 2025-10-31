import {
  Controller,
  Get,
  Patch,
  Body,
  BadRequestException,
} from '@nestjs/common';
import { UserService } from './user.service';
import { UpdateUserDto } from './dto/update-user.dto';
import { GetUser } from '../common/decorators/get-user.decorator';
import type { IUser } from '../common/interfaces/user.interface';

@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Get('profile')
  async getProfile(@GetUser() user: IUser) {
    if (!user || typeof user !== 'object' || !('_id' in user)) {
      return new BadRequestException('Invalid user object');
    }
    return this.userService.findById(user._id);
  }

  @Patch('update')
  async updateProfile(
    @GetUser() user: IUser,
    @Body() updateUserDto: UpdateUserDto,
  ) {
    if (!user || typeof user !== 'object' || !('_id' in user)) {
      throw new BadRequestException('Invalid user object');
    }
    return this.userService.update(user._id, updateUserDto);
  }
}
