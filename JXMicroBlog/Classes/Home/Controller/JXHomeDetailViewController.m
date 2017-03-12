//
//  JXHomeDetailViewController.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/11.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXHomeDetailViewController.h"
#import "JXHomeDetailFrame.h"
#import "JXHomeStautsDetailView.h"
#import "JXHomeRetweetFrame.h"
#import "JXStatus.h"
#import "JXHomeDetailBottomToolbar.h"
#import "JXHomeDetailTopToolbar.h"

@interface JXHomeDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 列表 */
@property (nonatomic,strong) UITableView * tableView;
/** 底部按钮 */
@property (nonatomic,weak) JXHomeDetailBottomToolbar *toolbar;
@end

@implementation JXHomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建tableView
    [self setupTableView];
    
    // 创建详细视图
    [self setupDetailView];
    
    // 创建底部toolbar
    [self setupDetailToolbar];
    
}

// 创建底部toolbar
- (void)setupDetailToolbar {
    JXHomeDetailBottomToolbar *toolbar = [[JXHomeDetailBottomToolbar alloc] init];
    toolbar.y = CGRectGetMaxY(self.tableView.frame);
    toolbar.w = self.view.w;
    toolbar.h = 44;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;

}

// 创建tableView
- (void)setupTableView {
    UITableView *tableView =[[UITableView alloc] init];
    tableView.w = kWidth;
    tableView.h = self.view.h - 44-20-44;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = kRGBColor(211, 211, 211, 1.0);
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

// 创建详细
- (void)setupDetailView {
    self.title = @"微博正文  ";
    
    JXHomeStautsDetailView *detailView = [[JXHomeStautsDetailView alloc] init];
    JXHomeDetailFrame *frame = [[JXHomeDetailFrame alloc] init];
    self.status.retweeted_status.detail = YES;
    frame.status = self.status;
    detailView.detailFrame = frame;
    detailView.h = frame.detailFrame.size.height;
    self.tableView.tableHeaderView = detailView;
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"reusecell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    JXHomeDetailTopToolbar *toolbar = [[JXHomeDetailTopToolbar alloc] init];
    return toolbar;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

@end
