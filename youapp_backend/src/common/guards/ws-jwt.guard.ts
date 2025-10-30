import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { Socket } from 'socket.io';
import { IUser } from '../interfaces/user.interface';
@Injectable()
export class WsJwtGuard implements CanActivate {
  constructor(private jwtService: JwtService) {}
  canActivate(context: ExecutionContext): boolean {
    const client: Socket = context.switchToWs().getClient();

    // Type guard for handshake.auth.token
    function hasAuthToken(
      handshake: unknown,
    ): handshake is { auth: { token: string } } {
      if (typeof handshake !== 'object' || handshake === null) return false;
      const h = handshake as Record<string, unknown>;
      if (!('auth' in h) || typeof h.auth !== 'object' || h.auth === null)
        return false;
      const auth = h.auth as Record<string, unknown>;
      return 'token' in auth && typeof auth.token === 'string';
    }

    if (!hasAuthToken(client.handshake)) {
      return false;
    }
    const token: string = client.handshake.auth.token;
    try {
      const user = this.jwtService.verify<IUser>(token);
      if (typeof client.data === 'object' && client.data !== null) {
        (client.data as { user?: IUser }).user = user;
      }
      return true;
    } catch {
      return false;
    }
  }
}
