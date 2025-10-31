import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { JwtModule } from '@nestjs/jwt';
import * as fs from 'fs';
import { Algorithm } from 'jsonwebtoken';
import { MongooseModule } from '@nestjs/mongoose';
import { User, UserSchema } from '../user/entities/user.entity';
import { forwardRef } from '@nestjs/common';
import { UserModule } from '../user/user.module';
import { PassportModule } from '@nestjs/passport';
import { JwtStrategy } from './strategies/jwt.strategy';
import { getJwtExpiresIn } from './jwt-expiration.util';

@Module({
  imports: [
    forwardRef(() => UserModule),
    PassportModule.register({ defaultStrategy: 'jwt' }),
    JwtModule.register({
      privateKey: fs.readFileSync(
        process.env.JWT_PRIVATE_KEY_PATH || './private.key',
        'utf8',
      ),
      publicKey: fs.readFileSync(
        process.env.JWT_PUBLIC_KEY_PATH || './public.key',
        'utf8',
      ),
      signOptions: {
        algorithm: (process.env.JWT_ALGORITHM || 'RS256') as Algorithm,
        expiresIn: getJwtExpiresIn(),
      },
      verifyOptions: {
        algorithms: [(process.env.JWT_ALGORITHM || 'RS256') as Algorithm],
      },
    }),
    MongooseModule.forFeature([{ name: User.name, schema: UserSchema }]),
  ],
  controllers: [AuthController],
  providers: [AuthService, JwtStrategy],
  exports: [AuthService, JwtModule, JwtStrategy],
})
export class AuthModule {}
