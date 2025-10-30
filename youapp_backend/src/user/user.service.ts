import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { User } from './entities/user.entity';
import { User as UserSchemaClass } from './entities/user.schema';
import { UpdateUserDto } from './dto/update-user.dto';

@Injectable()
export class UserService {
  constructor(
    @InjectModel(User.name) private userModel: Model<User>,
    @InjectModel(UserSchemaClass.name)
    private userSchemaModel: Model<UserSchemaClass>,
  ) {}
  // CRUD for MongoDB user collection
  async createUserMongo(
    data: Partial<UserSchemaClass>,
  ): Promise<UserSchemaClass> {
    const user = new this.userSchemaModel(data);
    return user.save();
  }

  async findAllUserMongo(): Promise<UserSchemaClass[]> {
    return this.userSchemaModel.find().exec();
  }

  async findById(id: string): Promise<User> {
    const user = await this.userModel.findById(id).select('-password');
    if (!user) {
      throw new NotFoundException('User not found');
    }
    return user;
  }

  async findByEmail(email: string): Promise<User | null> {
    return this.userModel.findOne({ email }).exec();
  }

  async findByUsername(username: string): Promise<User | null> {
    return this.userModel.findOne({ username }).exec();
  }

  async update(id: string, updateUserDto: UpdateUserDto): Promise<User> {
    const user = await this.userModel
      .findByIdAndUpdate(id, updateUserDto, { new: true })
      .select('-password');
    if (!user) {
      throw new NotFoundException('User not found');
    }
    return user;
  }
}
