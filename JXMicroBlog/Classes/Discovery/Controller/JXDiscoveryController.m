//
//  JXDiscoveryController.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2016/12/13.
//  Copyright © 2016年 王加祥. All rights reserved.
//

#import "JXDiscoveryController.h"
#import "JXTextField.h" // 搜索框
#import "JXGlobalGroup.h" // 组数据
#import "JXGlobalItem.h"
#import "JXGlobalCell.h"
#import "JXGlobalSwitchItem.h"
#import "JXGlobalArrowItem.h"
#import "JXGlobalTextItem.h"

@interface JXDiscoveryController ()

@end

@implementation JXDiscoveryController



- (void)viewDidLoad {
    [super viewDidLoad];
    // 搜索框
    JXTextField *textField = [JXTextField createSearch];
    textField.w = kWidth;
    textField.h = 30;
    self.navigationItem.titleView = textField;
    
    // 初始化数据模型
    [self setupGroups];
}
- (void)setupGroups {
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    
}

- (void)setupGroup0 {
    JXGlobalGroup *group = [JXGlobalGroup group];
    [self.groups addObject:group];
    
    // 设置组信息
    group.header = @"第0组表头";
    group.footer = @"第0组组尾部";
    
    // 设置组的所有行数据
    JXGlobalArrowItem *hotItem = [JXGlobalArrowItem itemWithTitle:@"热门微博" icon:@"hot_status"];
    hotItem.subTitle = @"笑话, 娱乐, 神什么鬼的都在这里";
    hotItem.bageVaule = @"909";
    hotItem.destVcClass = [UIViewController class];
    
    JXGlobalArrowItem *findItem = [JXGlobalArrowItem itemWithTitle:@"招人" icon:@"find_people"];
    findItem.subTitle = @"你老公老婆都在这里";
    
    group.items = @[hotItem,findItem];
}

- (void)setupGroup1 {
    
    JXGlobalGroup *group = [JXGlobalGroup group];
    [self.groups addObject:group];
    
    // 设置组信息
    group.header = @"第1组表头";
    group.footer = @"第1组组尾部";
    
    // 设置组的所有行数据
    JXGlobalItem *gameItem = [JXGlobalItem itemWithTitle:@"游戏中心" icon:@"game_center"];
    gameItem.globalItemOperationBlock = ^(){
        JXLog(@"点击了游戏");
    };
    JXGlobalItem *nearItem = [JXGlobalItem itemWithTitle:@"周边" icon:@"near"];
    
    JXGlobalItem *appItem = [JXGlobalItem itemWithTitle:@"应用" icon:@"app"];

    group.items = @[gameItem,nearItem,appItem];
}

- (void)setupGroup2 {
    JXGlobalGroup *group = [JXGlobalGroup group];
    [self.groups addObject:group];
    
    // 设置组信息
    group.header = @"第2组表头";
    group.footer = @"第2组组尾部";
    
    // 设置组的所有行数据
    JXGlobalTextItem *videoItem = [JXGlobalTextItem itemWithTitle:@"视频" icon:@"video"];
    videoItem.text = @"超多好看电影";
    JXGlobalItem *musicItem = [JXGlobalItem itemWithTitle:@"音乐" icon:@"music"];
    JXGlobalItem *movieItem = [JXGlobalItem itemWithTitle:@"电影" icon:@"movie"];
    JXGlobalItem *castItem = [JXGlobalItem itemWithTitle:@"播客" icon:@"cast"];
    JXGlobalItem *moreItem = [JXGlobalItem itemWithTitle:@"更多" icon:@"more"];
    
    group.items = @[videoItem,musicItem,movieItem,castItem,moreItem];
}


@end
