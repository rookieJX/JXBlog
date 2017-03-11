//
//  JXMeController.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2016/12/13.
//  Copyright © 2016年 王加祥. All rights reserved.
//

#import "JXMeController.h"
#import "JXTextField.h" // 搜索框
#import "JXGlobalGroup.h" // 组数据
#import "JXGlobalItem.h"
#import "JXGlobalCell.h"
#import "JXGlobalSwitchItem.h"
#import "JXGlobalArrowItem.h"
#import "JXGlobalTextItem.h"
#import "JXSettingController.h"

@interface JXMeController ()
/** 数组 */
@property (nonatomic,strong) NSMutableArray * groups;
@end

@implementation JXMeController

- (NSMutableArray *)groups{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRGBColor(211, 211, 211, 1.0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = 10;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(profile)];
    
    // 初始化数据模型
    [self setupGroups];
}

- (void)profile {
    JXSettingController *setting = [[JXSettingController alloc] init];
    [self.navigationController pushViewController:setting animated:YES];
}
- (void)setupGroups {
    [self setupGroup0];
    [self setupGroup1];
    
}

- (void)setupGroup0 {
    JXGlobalGroup *group = [JXGlobalGroup group];
    [self.groups addObject:group];
    
    // 设置组信息
    group.header = @"第0组表头";
    group.footer = @"第0组组尾部";
    
    // 设置组的所有行数据
    JXGlobalArrowItem *newFriendItem = [JXGlobalArrowItem itemWithTitle:@"新的好友" icon:@"new_friend"];
    newFriendItem.bageVaule = @"5";
    newFriendItem.destVcClass = [UIViewController class];
    
    group.items = @[newFriendItem];
}

- (void)setupGroup1 {
    
    JXGlobalGroup *group = [JXGlobalGroup group];
    [self.groups addObject:group];
    
    // 设置组信息
    group.header = @"第1组表头";
    group.footer = @"第1组组尾部";
    
    // 设置组的所有行数据
    JXGlobalItem *albumItem = [JXGlobalItem itemWithTitle:@"我的相册" icon:@"album"];
    albumItem.subTitle = @"(10)";
    albumItem.globalItemOperationBlock = ^(){
        JXLog(@"点击了游戏");
    };
    JXGlobalItem *collectItem = [JXGlobalItem itemWithTitle:@"我的收藏" icon:@"collect"];
    collectItem.subTitle = @"(10)";
    collectItem.bageVaule = @"1";
    JXGlobalItem *likeItem = [JXGlobalItem itemWithTitle:@"赞" icon:@"like"];
    likeItem.subTitle = @"(10)";
    likeItem.bageVaule = @"1";
    group.items = @[albumItem,collectItem,likeItem];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    JXGlobalGroup *group = self.groups[section];
    return group.items.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JXGlobalCell *cell = [JXGlobalCell cellWithTableView:tableView];
    JXGlobalGroup *group = self.groups[indexPath.section];
    JXGlobalItem *item = group.items[indexPath.row];
    cell.item = item;
    cell.indexPath = indexPath;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JXGlobalGroup *group = self.groups[indexPath.section];
    JXGlobalItem *item = group.items[indexPath.row];
    
    // 如果有类
    if (item.destVcClass) {
        UIViewController *destVc = [[item.destVcClass alloc] init];
        [self.navigationController pushViewController:destVc animated:YES];
    }
    
    // 如果实现了block
    if (item.globalItemOperationBlock) {
        item.globalItemOperationBlock();
    }
}

- (instancetype)init
{
    
    return [self initWithStyle:UITableViewStyleGrouped];
}
@end
