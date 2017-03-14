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
#import "JXHomeStatusDetailResult.h"
#import "JXHomeStatusDetailParams.h"
#import "JXStatusTool.h"

@interface JXHomeDetailViewController ()<UITableViewDelegate,UITableViewDataSource,JXHomeDetailTopToolbarDelegate>
/** 列表 */
@property (nonatomic,strong) UITableView * tableView;
/** 底部按钮 */
@property (nonatomic,weak) JXHomeDetailBottomToolbar *toolbar;
/** 评论内容 */
@property (nonatomic,strong) NSMutableArray * comments;
@end

@implementation JXHomeDetailViewController

- (NSMutableArray *)comments{
    if (_comments == nil) {
        _comments = [[NSMutableArray alloc] init];
    }
    return _comments;
}

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
    return self.comments.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"reusecell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    JXHomeStatusDetailCommentResult *result = self.comments[indexPath.row];
    cell.textLabel.text = result.text;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    JXHomeDetailTopToolbar *toolbar = [[JXHomeDetailTopToolbar alloc] init];
    toolbar.delegate = self;
    toolbar.status = self.status;
    return toolbar;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

#pragma mark - JXHomeDetailTopToolbarDelegate
- (void)topToolbar:(JXHomeDetailTopToolbar *)toolbar didClickButtonType:(JXHomeDetailTopToolbarType)type {
    switch (type) {
        case JXHomeDetailTopToolbarComent:
            [self loadComment];
            break;
        case JXHomeDetailTopToolbarPraise:
            break;
        case JXHomeDetailTopToolbarForward:
            [self loadForward];
            break;
        default:
            break;
    }
}

// 加载转发数据
- (void)loadForward {
    
}

// 加载评论
- (void)loadComment {
    
    
    JXAccount *account = [JXAccountTool account];
    
    JXHomeStatusDetailParams *detailParams = [[JXHomeStatusDetailParams alloc] init];
    detailParams.access_token = account.access_token;
    detailParams.statusID = self.status.idstr;
    JXHomeStatusDetailCommentResult *result = [self.comments firstObject];
    detailParams.since_id = result.idstr;
    
    
    [JXStatusTool detailCountWithParams:detailParams success:^(JXHomeStatusDetailResult *result) {
//        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, result.comments.count)];
//        [self.comments insertObjects:result.comments atIndexes:set];
        [self.comments addObjectsFromArray:result.comments];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
   

}
@end
