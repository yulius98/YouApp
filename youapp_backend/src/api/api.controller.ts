import {
  Controller,
  Post,
  Body,
  UseGuards,
  Get,
  Put,
  HttpCode,
  HttpStatus,
} from '@nestjs/common';
import { AuthService } from '../auth/auth.service';
import { UserService } from '../user/user.service';
import { JwtAuthGuard } from '../common/guards/jwt-auth.guard';
import { GetUser } from '../common/decorators/get-user.decorator';
import type { JwtUser } from '../common/decorators/get-user.decorator';
import { UpdateUserDto } from '../user/dto/update-user.dto';
import { JwtService } from '@nestjs/jwt';
import { comparePassword } from '../common/utils/hash.util';

@Controller('api')
export class ApiController {
  constructor(
    private readonly authService: AuthService,
    private readonly userService: UserService,
    private readonly jwtService: JwtService,
  ) {}

  @Post('register')
  async register(
    @Body() body: { email: string; username: string; password: string },
  ) {
    // map username -> name and username
    const registerDto = {
      email: body.email,
      password: body.password,
      name: body.username,
      username: body.username,
    };
    await this.authService.register(registerDto);
    return {
      status: true,
      message: 'User has been created successfully',
    };
  }

  @Post('login')
  @HttpCode(HttpStatus.OK)
  async login(
    @Body() body: { email?: string; username?: string; password: string },
  ) {
    const { email, username, password } = body;
    let user = null as null | { _id: string; email: string; password: string };
    if (email) {
      user = (await this.userService.findByEmail(email)) as {
        _id: string;
        email: string;
        password: string;
      } | null;
    }
    if (!user && username) {
      user = (await this.userService.findByUsername(username)) as {
        _id: string;
        email: string;
        password: string;
      } | null;
    }
    if (!user) {
      return { status: false, message: 'Invalid credentials' };
    }
    const valid = await comparePassword(password, user.password);
    if (!valid) {
      return { status: false, message: 'Invalid credentials' };
    }
    const token = this.jwtService.sign({ sub: user._id, email: user.email });
    return {
      status: true,
      message: 'User has been logged in successfully',
      access_token: token,
    };
  }

  @UseGuards(JwtAuthGuard)
  @Post('createProfile')
  async createProfile(@GetUser() user: JwtUser, @Body() body: UpdateUserDto) {
    await this.userService.update(user._id, body);
    return {
      status: true,
      message: 'Profile has been created',
    };
  }

  @UseGuards(JwtAuthGuard)
  @Put('updateProfile')
  async updateProfile(@GetUser() user: JwtUser, @Body() body: UpdateUserDto) {
    await this.userService.update(user._id, body);
    return {
      status: true,
      message: 'Profile has been updated',
    };
  }

  @UseGuards(JwtAuthGuard)
  @Get('getProfile')
  async getProfile(@GetUser() user: JwtUser) {
    const profile = await this.userService.findById(user._id);
    return {
      status: true,
      ...profile,
    };
  }
}
