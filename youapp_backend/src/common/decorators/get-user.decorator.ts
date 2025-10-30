import { Request } from 'express';
import { createParamDecorator, ExecutionContext } from '@nestjs/common';

export interface JwtUser {
  _id: string;
  email: string;
}

export const GetUser = createParamDecorator(
  (data: unknown, ctx: ExecutionContext): JwtUser | undefined => {
    const request = ctx.switchToHttp().getRequest<Request>();
    return (request as Request & { user?: JwtUser }).user;
  },
);
