import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model, Types, FilterQuery } from 'mongoose';
import { Group } from './entities/group.entity';
import { GroupMessage } from './entities/group-message.entity';
import { CreateGroupDto } from './dto/create-group.dto';
import { SendGroupMessageDto } from './dto/send-group-message.dto';
import { UpdateGroupMemberDto } from './dto/update-group-member.dto';
import { AmqpConnection } from '@golevelup/nestjs-rabbitmq';

interface LeanGroupMessage {
  _id: Types.ObjectId;
  senderId: Types.ObjectId;
  content: string;
  timestamp: Date;
}

@Injectable()
export class GroupService {
  constructor(
    @InjectModel(Group.name) private groupModel: Model<Group>,
    @InjectModel(GroupMessage.name)
    private groupMessageModel: Model<GroupMessage>,
    private readonly amqpConnection: AmqpConnection,
  ) {}

  async createGroup(creatorId: string, dto: CreateGroupDto) {
    const group = await this.groupModel.create({
      name: dto.name,
      members: [
        new Types.ObjectId(creatorId),
        ...dto.members.map((id) => new Types.ObjectId(id)),
      ],
    });
    return { groupId: group._id, name: group.name, members: group.members };
  }

  async sendGroupMessage(
    senderId: string,
    groupId: string,
    dto: SendGroupMessageDto,
  ) {
    await this.amqpConnection.publish('group_chat_exchange', 'group_chat', {
      groupId,
      senderId,
      content: dto.content,
      timestamp: new Date(),
    });
    return {
      messageId: new Types.ObjectId(),
      content: dto.content,
      senderId,
      timestamp: new Date(),
    };
  }

  async getGroupChatHistory(
    groupId: string,
    options: { page: number; limit: number; since?: string },
  ) {
    const group = await this.groupModel.findById(groupId);
    if (!group) throw new NotFoundException('Group not found');
    const query: FilterQuery<GroupMessage> = { groupId };
    if (options.since) query.timestamp = { $gt: new Date(options.since) };
    const messages = (await this.groupMessageModel
      .find(query)
      .sort({ timestamp: -1 })
      .skip((options.page - 1) * options.limit)
      .limit(options.limit)
      .lean()) as unknown as LeanGroupMessage[];
    return messages.map((msg: LeanGroupMessage) => ({
      messageId:
        typeof msg._id === 'object' && msg._id && 'toString' in msg._id
          ? (msg._id as { toString: () => string }).toString()
          : String(msg._id),
      senderId:
        typeof msg.senderId === 'object' &&
        msg.senderId &&
        'toString' in msg.senderId
          ? (msg.senderId as { toString: () => string }).toString()
          : String(msg.senderId),
      content: String(msg.content),
      timestamp: msg.timestamp,
    }));
  }

  async getAllGroups(userId: string) {
    const groups = await this.groupModel.find({ members: userId }).lean();
    return groups.map((group) => ({
      groupId: group._id,
      name: group.name,
      membersCount: group.members.length,
    }));
  }
  async updateGroupMember(groupId: string, dto: UpdateGroupMemberDto) {
    const group = await this.groupModel.findById(groupId);
    if (!group) throw new NotFoundException('Group not found');
    let messageId = '';
    if (dto.action === 'add') {
      const userObjId = new Types.ObjectId(dto.userId);
      if (!group.members.some((id) => id.equals(userObjId))) {
        group.members.push(userObjId);
        await group.save();
      }
      messageId = 'user successfully added to group';
    } else if (dto.action === 'remove') {
      group.members = group.members.filter(
        (id) => id.toString() !== dto.userId,
      );
      await group.save();
      messageId = 'user successfully removed from group ';
    }
    return {
      messageId,
      data: {
        groupId: group._id,
        action: dto.action,
        userId: dto.userId,
        updateAt: new Date(),
      },
    };
  }
}
