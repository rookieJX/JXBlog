//
//  JXSettingController.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/11.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXSettingController.h"
#import "JXGlobalGroup.h" // 组数据
#import "JXGlobalItem.h"
#import "JXGlobalSwitchItem.h"
#import "JXGlobalArrowItem.h"
#import "JXGlobalTextItem.h"
#import "JXGlobalLogoutItem.h"
#import "JXMeMessageController.h"

@implementation JXSettingController

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
    
    // 设置组的所有行数据
    JXGlobalArrowItem *countItem = [JXGlobalArrowItem itemWithTitle:@"账号管理"];
    
    JXGlobalArrowItem *safeItem = [JXGlobalArrowItem itemWithTitle:@"账号安全"];
    
    group.items = @[countItem,safeItem];
}

- (void)setupGroup1 {
    
    JXGlobalGroup *group = [JXGlobalGroup group];
    [self.groups addObject:group];
    
    
    // 设置组的所有行数据
    JXGlobalArrowItem *message = [JXGlobalArrowItem itemWithTitle:@"消息设置"];
    message.destVcClass = [JXMeMessageController class];
    
    JXGlobalArrowItem *shield = [JXGlobalArrowItem itemWithTitle:@"屏蔽设置"];
    
    JXGlobalArrowItem *pravicy = [JXGlobalArrowItem itemWithTitle:@"隐私"];
    
    JXGlobalArrowItem *genera = [JXGlobalArrowItem itemWithTitle:@"通用设置"];
    group.items = @[message,shield,pravicy,genera];
}

- (void)setupGroup2 {
    JXGlobalGroup *group = [JXGlobalGroup group];
    [self.groups addObject:group];
    
    // 设置组的所有行数据
    JXGlobalTextItem *clean = [JXGlobalTextItem itemWithTitle:@"清理缓存"];
    clean.text = @"100M";
    
    JXGlobalArrowItem *opinion = [JXGlobalArrowItem itemWithTitle:@"意见反馈"];
    
    JXGlobalArrowItem *service = [JXGlobalArrowItem itemWithTitle:@"客服中心"];
    
    JXGlobalArrowItem *about = [JXGlobalArrowItem itemWithTitle:@"关于微博"];
    group.items = @[clean,opinion,service,about];

}

- (void)setupGroup3 {
    JXGlobalGroup *group = [JXGlobalGroup group];
    [self.groups addObject:group];
    
    // 设置组的所有行数据
    JXGlobalLogoutItem *logout = [JXGlobalLogoutItem itemWithTitle:@"退出登录"];
    group.items = @[logout];
    
}


@end
