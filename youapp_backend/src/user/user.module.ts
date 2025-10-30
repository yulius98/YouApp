import { Module } from '@nestjs/common';
import { UserService } from './user.service';
import { UserController } from './user.controller';
import { ApiController } from '../api/api.controller';
import { MongooseModule } from '@nestjs/mongoose';
import {
  User as UserEntity,
  UserSchema as UserEntitySchema,
} from './entities/user.entity';
import {
  User as UserSchemaClass,
  UserSchema as UserSchemaMongo,
} from './entities/user.schema';

import { forwardRef } from '@nestjs/common';
import { AuthModule } from '../auth/auth.module';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: UserEntity.name, schema: UserEntitySchema },
      { name: UserSchemaClass.name, schema: UserSchemaMongo },
    ]),
    forwardRef(() => AuthModule),
  ],
  controllers: [UserController, ApiController],
  providers: [UserService],
  exports: [UserService],
})
export class UserModule {}
