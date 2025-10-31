import { Controller, Post, Body, Get, Param, Query } from '@nestjs/common';
import { GroupService } from './group.service.js';
import { CreateGroupDto } from './dto/create-group.dto';
import { SendGroupMessageDto } from './dto/send-group-message.dto';
import { UpdateGroupMemberDto } from './dto/update-group-member.dto';
import { GetUser } from '../common/decorators/get-user.decorator';

@Controller('api/groups')
export class GroupController {
  constructor(private readonly groupService: GroupService) {}

  @Post()
  createGroup(
    @Body() dto: CreateGroupDto,
    @GetUser() user: { _id: string; email: string },
  ) {
    const creatorId = user._id;
    return this.groupService.createGroup(creatorId, dto);
  }

  @Post(':groupId/sendMessage')
  async sendGroupMessage(
    @Param('groupId') groupId: string,
    @Body() dto: SendGroupMessageDto,
    @GetUser() user: { _id: string; email: string },
  ) {
    const senderId = user._id;
    return this.groupService.sendGroupMessage(senderId, groupId, dto);
  }

  @Get(':groupId/viewMessage')
  async getGroupChatHistory(
    @Param('groupId') groupId: string,
    @Query('page') page = 1,
    @Query('limit') limit = 10,
    @Query('since') since?: string,
  ) {
    return this.groupService.getGroupChatHistory(groupId, {
      page: +page,
      limit: +limit,
      since,
    });
  }

  @Get()
  async getAllGroups(@GetUser() user: { _id: string; email: string }) {
    const userId = user._id;
    return this.groupService.getAllGroups(userId);
  }

  @Post(':groupId/members')
  async updateGroupMember(
    @Param('groupId') groupId: string,
    @Body() dto: UpdateGroupMemberDto,
  ) {
    return this.groupService.updateGroupMember(groupId, dto);
  }
}
