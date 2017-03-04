//
//  JXHomeStatusCell.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/20.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXHomeStatusCell.h"
#import "JXHomeStautsToolBar.h" // 首页底部工具条
#import "JXHomeStautsDetailView.h" // 首页微博内容(原创+转发)
#import "JXHomeStatusFrame.h"


@interface JXHomeStatusCell ()<JXHomeStautsToolBarDelegate>
/** 工具条 */
@property (nonatomic,weak) JXHomeStautsToolBar * homeToolbar;
/** 微博内容 */
@property (nonatomic,weak) JXHomeStautsDetailView * homeDetailView;
@end

@implementation JXHomeStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupHomeToolbar];
        [self setupHomeDetail];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"homeCell";
    JXHomeStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[JXHomeStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
// 创建工具条
- (void)setupHomeToolbar {
    JXHomeStautsToolBar *homeToolbar = [[JXHomeStautsToolBar alloc] init];
    homeToolbar.delegate = self;
    [self.contentView addSubview:homeToolbar];
    self.homeToolbar = homeToolbar;
}

#pragma mark - 点击代理
- (void)homeStatusToolbar:(JXHomeStautsToolBar *)toolbar didSelectWithType:(HomeStatusType)type {
    if ([self.delegate respondsToSelector:@selector(homeStatusCellSelectWithType:)]) {
        [self.delegate homeStatusCellSelectWithType:type];
    }
}
// 创建微博内容
- (void)setupHomeDetail {
    
    JXHomeStautsDetailView *homeDetailView = [[JXHomeStautsDetailView alloc] init];
    [self.contentView addSubview:homeDetailView];
    self.homeDetailView = homeDetailView;
}

- (void)setStatusFrame:(JXHomeStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    
    // 详细内容
    self.homeDetailView.detailFrame = statusFrame.detailFrame;
    
    // 底部工具条
    self.homeToolbar.frame = statusFrame.toolbarFrame;
    
    self.homeToolbar.status = statusFrame.stauts;
}


@end
