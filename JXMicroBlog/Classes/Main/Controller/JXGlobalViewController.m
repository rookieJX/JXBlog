//
//  JXGlobalViewController.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2016/12/13.
//  Copyright © 2016年 王加祥. All rights reserved.
//

#import "JXGlobalViewController.h"
#import "JXGlobalGroup.h" // 组数据
#import "JXGlobalItem.h"
#import "JXGlobalCell.h"
#import "JXGlobalSwitchItem.h"
#import "JXGlobalArrowItem.h"
#import "JXGlobalTextItem.h"

@interface JXGlobalViewController ()
/** 数组 */
@property (nonatomic,strong) NSMutableArray * groups;
@end

@implementation JXGlobalViewController

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
    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
   
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
        destVc.title = item.title;
        [self.navigationController pushViewController:destVc animated:YES];
    }
    
    // 如果实现了block
    if (item.globalItemOperationBlock) {
        item.globalItemOperationBlock();
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    JXGlobalGroup *group = self.groups[section];
    return group.header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    JXGlobalGroup *group = self.groups[section];
    return group.footer;
}

- (instancetype)init
{
    
    return [self initWithStyle:UITableViewStyleGrouped];
}
@end
