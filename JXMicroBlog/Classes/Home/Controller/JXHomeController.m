//
//  JXHomeController.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2016/12/13.
//  Copyright © 2016年 王加祥. All rights reserved.
//

#import "JXHomeController.h"
#import "JXTitleButton.h" // 自定义顶部按钮
#import "JXPopView.h" // 弹出视图
#import "JXHomeParams.h" // 请求首页参数模型
#import "JXHomeStatusFrame.h" // 首页模型
#import "JXShowUserParams.h" // 获取用户昵称
#import "JXUserModel.h"
#import "JXStatusTool.h" // 加载首页信息
#import "JXStatus.h"
#import "JXHomeStatusCell.h"

@interface JXHomeController ()<UITableViewDelegate,UITableViewDataSource,JXHomeStatusCellDelegate>

/** 首页模型 */
@property (nonatomic,strong) NSMutableArray * statusFrameArray;
/** 列表 */
@property (nonatomic,weak) UITableView * tableView;
/** 当前页数 */
@property (nonatomic,assign) NSInteger currentPage;
/** 用户昵称按钮 */
@property (nonatomic,weak) JXTitleButton *titleButton;

@end

@implementation JXHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavigation];
    
    // 下拉刷新
    [self loadHomeNewData];
    
    // 获取用户昵称
    [self setupUserName];
    
}

- (void)setupUserName {
    JXShowUserParams *showUserParams = [[JXShowUserParams alloc] init];
    JXAccount *account = [JXAccountTool account];
    showUserParams.access_token = account.access_token;
    showUserParams.uid = account.uid;
    
    [JXStatusTool userInfoWithParams:showUserParams success:^(JXUserModel *homeStatus) {
        [self.titleButton setTitle:homeStatus.name forState:UIControlStateNormal];
        
        JXAccount *account = [JXAccountTool account];
        account.name = homeStatus.name;
        [JXAccountTool saveAccount:account];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"获取昵称出错 "];
    }];
    
}
// 集成刷新
- (void)loadHomeNewData {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                     refreshingAction:@selector(loadNewStatus)];
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                             refreshingAction:@selector(loadMoreStatus)];
    self.tableView.mj_footer = footer;

}

// 首页数组
- (NSMutableArray *)statusFrameArray{
    if (_statusFrameArray == nil) {
        _statusFrameArray = [NSMutableArray array];
    }
    return _statusFrameArray;
}
// 请求首页信息
- (void)loadNewStatus {
    
    self.currentPage = 1;
    // 如果还在下拉刷新
    if ([self.tableView.mj_footer isRefreshing]) {
        [self.tableView.mj_footer endRefreshing];
    }
    
    JXAccount *account = [JXAccountTool account];
    
    JXHomeParams *homeParams = [[JXHomeParams alloc] init];
    homeParams.access_token = account.access_token;
    homeParams.count = 20 ;
    homeParams.page = self.currentPage;
    
    JXHomeStatusFrame *statusFrame = [self.statusFrameArray lastObject];
    JXStatus *status = statusFrame.stauts;
    if (status) {
        homeParams.since_id = [status.idstr integerValue];
    }
    
    [JXStatusTool homeStatusWithParams:homeParams success:^(JXHomeStatusResultModel *homeStatus) {
        [self.tableView.mj_header endRefreshing];
        NSArray *newStatus = [self statusFramesWithStatus:homeStatus.statuses];
        
        // 将最新的微博数据插入到已存在的微博最前
        NSRange range = NSMakeRange(0, newStatus.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrameArray insertObjects:newStatus atIndexes:indexSet];
        [self showNewStatus:newStatus.count];
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
    
}

// 根据微博数组转成微博frame模型数组
- (NSArray *)statusFramesWithStatus:(NSArray *)status {
    NSMutableArray *frames = [NSMutableArray array];
    for (JXStatus *homeStatus in status) {
        JXHomeStatusFrame *homeFrame = [[JXHomeStatusFrame alloc] init];
        homeFrame.stauts = homeStatus;
        [frames addObject:homeFrame];
    }
    return frames;
}

// 加载更多
- (void)loadMoreStatus {
    self.currentPage++;
    // 如果还在下拉刷新
    if ([self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
    }
    
    JXAccount *account = [JXAccountTool account];
    
    JXHomeParams *homeParams = [[JXHomeParams alloc] init];
    homeParams.access_token = account.access_token;
    homeParams.count = 20;
    homeParams.page = self.currentPage;
    
    JXHomeStatusFrame *statusFrame = [self.statusFrameArray lastObject];
    JXStatus *status = statusFrame.stauts;
    if (status) {
        homeParams.max_id = [status.idstr integerValue] - 1;
    }
    
    [JXStatusTool homeStatusWithParams:homeParams success:^(JXHomeStatusResultModel *homeStatus) {
        NSArray *moreStatus = [self statusFramesWithStatus:homeStatus.statuses];
        
        [self.statusFrameArray addObjectsFromArray:moreStatus];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];

    } failure:^(NSError *error) {
       [self.tableView.mj_footer endRefreshing];
    }];
    
}

// 添加更新微博信息
- (void)showNewStatus:(NSInteger)count {
    
    // 下标,以及应用角标
    [UIApplication sharedApplication].applicationIconBadgeNumber -= self.tabBarItem.badgeValue.integerValue;
    self.tabBarItem.badgeValue = nil;
    
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navigationbar_background"]];
    label.textAlignment = NSTextAlignmentCenter;
    if (count) {
        label.text = [NSString stringWithFormat:@"更新了%ld条微博",count];
    } else {
        label.text = @"暂无最新微博";
    }
    label.textColor = [UIColor whiteColor];
    label.w = kWidth;
    label.h = 35;
    label.x = 0;
    label.y = kStatusH + kNavigateH - label.h;
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    CGFloat duration = 1.0f;
    [UIView animateWithDuration:duration animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.h);
    } completion:^(BOOL finished) {
        CGFloat delay = 1.0f;
        [UIView animateWithDuration:duration delay:delay options:0 animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}
// 导航栏按钮
- (void)setupNavigation {
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_friendsearch"
                                                                 highImageName:@"navigationbar_friendsearch_highlighted"
                                                                        target:self
                                                                        action:@selector(frindSearch)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_pop"
                                                                  highImageName:@"navigationbar_pop_highlighted"
                                                                         target:self
                                                                         action:@selector(pop)];
    
    JXTitleButton *titleButton = [[JXTitleButton alloc] init];
    titleButton.h = 30;
    
    JXAccount *account = [JXAccountTool account];
    NSString *name = account.name;
    [titleButton setTitle:name ? name : @"首页" forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(home:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    self.titleButton = titleButton;
}
- (void)frindSearch {
    JXLog(@"左边");

}
- (void)pop {
    JXLog(@"右边");
}

- (void)home:(JXTitleButton *)sender {
    CGRect frame = CGRectMake(kWidth/2-50, 100, 100, 100);
    UIView *view = [[UIView alloc] init];
    view.bounds = CGRectMake(0, 0, 100, 100);
    view.backgroundColor = kRandColor;
    
    JXPopView *popView = [[JXPopView alloc] initWithPopView:view];
    [popView showPopViewRect:frame];
}


// 列表
- (UITableView *)tableView{
    if (_tableView == nil) {
        CGRect frame = CGRectMake(0, 0, kWidth, kHeight-kBottomH-kStatusH-kNavigateH);
        UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = kRGBColor(211, 211, 211, 1.0);
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate && DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = self.statusFrameArray.count;
    self.tableView.mj_footer.hidden = count == 0;
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JXHomeStatusCell * cell = [JXHomeStatusCell cellWithTableView:tableView];
    cell.delegate = self;
    JXHomeStatusFrame *status = self.statusFrameArray[indexPath.row];
    cell.statusFrame = status;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    JXHomeStatusFrame *frame = self.statusFrameArray[indexPath.row];
    return frame.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark - 点击celltoolbar
- (void)homeStatusCellSelectWithType:(HomeStatusType)type {
    switch (type) {
        case HomeStatusTypePraise:
            JXLog(@"点赞");
            break;
        case HomeStatusTypeComment:
            JXLog(@"评论");
            break;
        case HomeStatusTypeRetweet:
            JXLog(@"转发");
            break;
        default:
            break;
    }
}
@end
