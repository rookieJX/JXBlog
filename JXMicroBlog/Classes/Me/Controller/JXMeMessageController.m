//
//  JXMeMessageController
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/11.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXMeMessageController.h"
#import "JXGlobalGroup.h" // 组数据
#import "JXGlobalItem.h"
#import "JXGlobalSwitchItem.h"
#import "JXGlobalArrowItem.h"
#import "JXGlobalTextItem.h"

@implementation JXMeMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化数据模型
    [self setupGroups];
}
- (void)setupGroups {
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
    
}

- (void)setupGroup0 {
    JXGlobalGroup *group = [JXGlobalGroup group];
    [self.groups addObject:group];
    group.footer = @"要开启或关闭微博的推送通知,请在iPhone的\"设置\"-\"通知\"中找到\"微博\"进行设置";
    // 设置组的所有行数据
    JXGlobalTextItem *countItem = [JXGlobalTextItem itemWithTitle:@"已开启"];
    
    group.items = @[countItem];
}

- (void)setupGroup1 {
    
    JXGlobalGroup *group = [JXGlobalGroup group];
    [self.groups addObject:group];
    group.header = @"通知提醒";
    
    // 设置组的所有行数据
    JXGlobalArrowItem *message = [JXGlobalArrowItem itemWithTitle:@"@我的"];
    
    JXGlobalArrowItem *shield = [JXGlobalArrowItem itemWithTitle:@"评论"];
    
    JXGlobalArrowItem *pravicy = [JXGlobalArrowItem itemWithTitle:@"赞"];
    group.items = @[message,shield,pravicy];
}

- (void)setupGroup2 {
    JXGlobalGroup *group = [JXGlobalGroup group];
    [self.groups addObject:group];
    group.header = @"聊天提醒";
    // 设置组的所有行数据
    JXGlobalSwitchItem *clean = [JXGlobalSwitchItem itemWithTitle:@"消息"];
    
    JXGlobalArrowItem *opinion = [JXGlobalArrowItem itemWithTitle:@"未关注人消息"];
    
    JXGlobalSwitchItem *service = [JXGlobalSwitchItem itemWithTitle:@"群通知"];
    group.items = @[clean,opinion,service];
    
}

- (void)setupGroup3 {
    JXGlobalGroup *group = [JXGlobalGroup group];
    [self.groups addObject:group];
    group.header = @"微博推送通知";
    
    // 设置组的所有行数据
    JXGlobalSwitchItem *clean = [JXGlobalSwitchItem itemWithTitle:@"好友圈微博"];
    
    JXGlobalArrowItem *opinion = [JXGlobalArrowItem itemWithTitle:@"特别关注微博"];
    
    JXGlobalSwitchItem *service = [JXGlobalSwitchItem itemWithTitle:@"微博热点"];
    
    group.items = @[clean,opinion,service];
    
}


@end
