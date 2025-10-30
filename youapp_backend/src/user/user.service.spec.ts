import { Test, TestingModule } from '@nestjs/testing';
import { UserService } from './user.service';
import { getModelToken } from '@nestjs/mongoose';
import { User } from './entities/user.entity';

describe('UserService', () => {
  let service: UserService;
  const mockUserModel = {
    findById: jest.fn().mockResolvedValue({ _id: '1', email: 'test' }),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        UserService,
        { provide: getModelToken(User.name), useValue: mockUserModel },
      ],
    }).compile();

    service = module.get<UserService>(UserService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should find user by id', async () => {
    const result = await service.findById('1');
    expect(result).toEqual({ _id: '1', email: 'test' });
  });
});
