//
//  JXHomeStautsToolBar.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/20.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXHomeStautsToolBar.h"
#import "JXStatus.h"

@interface JXHomeStautsToolBar()
/** 按钮数组 */
@property (nonatomic, strong) NSMutableArray * btns;
/** 分割竖线 */
@property (nonatomic, strong) NSMutableArray * dividers;
/** 分割横线 */
@property (nonatomic,weak) UIView * deveLineView;
/** 点赞 */
@property (nonatomic,weak) UIButton * attibuteBtn;
/** 评论 */
@property (nonatomic,weak) UIButton * commentBtn;
/** 转发 */
@property (nonatomic,weak) UIButton * repostsBtn;
@end

@implementation JXHomeStautsToolBar

- (NSMutableArray *)btns
{
    if (_btns == nil) {
        self.btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)dividers
{
    if (_dividers == nil) {
        self.dividers = [NSMutableArray array];
    }
    return _dividers;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kRGBColor(255, 255, 255, 1.0);
        self.repostsBtn = [self setupBtnWithIcon:@"timeline_icon_retweet" title:@"转发" type:HomeStatusTypeRetweet];
        self.commentBtn = [self setupBtnWithIcon:@"timeline_icon_comment" title:@"评论" type:HomeStatusTypeComment];
        self.attibuteBtn = [self setupBtnWithIcon:@"timeline_icon_unlike" title:@"赞" type:HomeStatusTypePraise];
        
        [self setupDivider];
        [self setupDivider];
        
        UIView * deveLineView = [[UIView alloc] init];
        deveLineView.backgroundColor = kRGBColor(240, 240, 240, 1.0);
        [self addSubview:deveLineView];
        self.deveLineView = deveLineView;
        
    }
    return self;
}


- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    divider.contentMode = UIViewContentModeCenter;
    [self addSubview:divider];
    
    [self.dividers addObject:divider];
}

- (UIButton *)setupBtnWithIcon:(NSString *)icon title:(NSString *)title type:(HomeStatusType)type
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.tag = type;
    
    [btn setBackgroundImage:[UIImage resizedImage:@"common_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    btn.adjustsImageWhenHighlighted = NO;
    
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}

- (void)btnClick:(UIButton *)sender {
    HomeStatusType type = (HomeStatusType)sender.tag;
    if ([self.delegate respondsToSelector:@selector(homeStatusToolbar:didSelectWithType:)]) {
        [self.delegate homeStatusToolbar:self didSelectWithType:type];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮的frame
    NSInteger btnCount = self.btns.count;
    CGFloat btnW = self.w / btnCount;
    CGFloat btnH = self.h;
    for (int i = 0; i<btnCount; i++) {
        UIButton *btn = self.btns[i];
        btn.w = btnW;
        btn.h = btnH;
        btn.y = 0;
        btn.x = i * btnW;
    }
    
    // 设置分割线的frame
    NSInteger dividerCount = self.dividers.count;
    for (int i = 0; i<dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.w = 4;
        divider.h = btnH;
        divider.centerX = (i + 1) * btnW;
        divider.centerY = btnH * 0.5;
    }
    
    self.deveLineView.frame = CGRectMake(0, 0, self.w ,1);
}

- (void)setStatus:(JXStatus *)status {
    _status = status;
    
    // 转发
    [self setupBtnTitle:self.repostsBtn count:status.reposts_count defaultTitle:@"转发"];
    
    // 赞
    [self setupBtnTitle:self.attibuteBtn count:status.attitudes_count defaultTitle:@"赞"];
    
    // 评论
    [self setupBtnTitle:self.commentBtn count:status.comments_count defaultTitle:@"评论"];
}

- (void)setupBtnTitle:(UIButton *)button count:(NSInteger)count defaultTitle:(NSString *)defaultTitle
{
    if (count >= 10000) { // [10000, 无限大)
        defaultTitle = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
        // 用空串替换掉所有的.0
        defaultTitle = [defaultTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
    } else if (count > 0) { // (0, 10000)
        defaultTitle = [NSString stringWithFormat:@"%ld", count];
    }
    [button setTitle:defaultTitle forState:UIControlStateNormal];
}

@end
