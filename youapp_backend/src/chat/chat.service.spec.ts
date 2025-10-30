import { Test, TestingModule } from '@nestjs/testing';
import { ChatService } from './chat.service';
import { getModelToken } from '@nestjs/mongoose';
import { Message } from './entities/message.entity';

describe('ChatService', () => {
  let service: ChatService;
  const mockMessageModel = {
    save: jest.fn().mockResolvedValue({ content: 'test' }),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        ChatService,
        { provide: getModelToken(Message.name), useValue: mockMessageModel },
      ],
    }).compile();

    service = module.get<ChatService>(ChatService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should create a message', async () => {
    const result = await service.create({ content: 'test', userId: '1' });
    expect(result).toEqual({ content: 'test' });
  });
});
