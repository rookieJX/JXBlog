//
//  JXHomeDetailTopToolbar.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/11.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXHomeDetailTopToolbar.h"
#import "JXStatus.h"

@interface JXHomeDetailTopToolbar()
/** 评论 */
@property (nonatomic,weak) UIButton * commentButton;
/** 选中按钮 */
@property (nonatomic,weak) UIButton * selectButton;
/** 转发 */
@property (nonatomic,weak) UIButton * repostsBtn;
/** 赞 */
@property (nonatomic,weak) UIButton * attibuteBtn;
@end

@implementation JXHomeDetailTopToolbar
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.repostsBtn = [self setupBtnWithIcon:@"timeline_icon_retweet" title:@"转发" type:JXHomeDetailTopToolbarForward];
        self.commentButton = [self setupBtnWithIcon:@"timeline_icon_comment" title:@"评论" type:JXHomeDetailTopToolbarComent];
        self.commentButton.selected = YES;
        self.attibuteBtn = [self setupBtnWithIcon:@"timeline_icon_unlike" title:@"赞" type:JXHomeDetailTopToolbarPraise];
    }
    return self;
}
/**
 *  添加按钮
 *
 *  @param icon  图标
 *  @param title 标题
 */
- (UIButton *)setupBtnWithIcon:(NSString *)icon title:(NSString *)title type:(JXHomeDetailTopToolbarType)type
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.tag = type;
    // 设置间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    return btn;
}

- (void)btnClick:(UIButton *)button {
    // 1.控制按钮状态
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
    
    JXHomeDetailTopToolbarType type = (JXHomeDetailTopToolbarType)button.tag;
    if (self.delegate && [self.delegate respondsToSelector:@selector(topToolbar:didClickButtonType:)]) {
        [self.delegate topToolbar:self didClickButtonType:type];
    }
}


// 默认选中代理
- (void)setDelegate:(id<JXHomeDetailTopToolbarDelegate>)delegate {
    _delegate = delegate;
    
    [self btnClick:self.commentButton];
}
- (void)drawRect:(CGRect)rect
{
    [[UIImage resizedImage:@"statusdetail_toolbar_background"] drawInRect:rect];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮的frame
    NSInteger btnCount = self.subviews.count;
    CGFloat margin = 10;
    CGFloat btnW = (self.w - (btnCount + 1) * margin) / btnCount;
    CGFloat btnY = 5;
    CGFloat btnH = self.h - 2 * btnY;
    for (int i = 0; i<btnCount; i++) {
        UIButton *btn = self.subviews[i];
        btn.w = btnW;
        btn.h = btnH;
        btn.y = btnY;
        btn.x = margin + i * (btnW + margin);
    }
}

- (void)setStatus:(JXStatus *)status {
    _status = status;
    
    // 转发
    [self setupBtnTitle:self.repostsBtn count:status.reposts_count defaultTitle:@"转发"];
    
    // 赞
    [self setupBtnTitle:self.attibuteBtn count:status.attitudes_count defaultTitle:@"赞"];
    
    // 评论
    [self setupBtnTitle:self.commentButton count:status.comments_count defaultTitle:@"评论"];
}

- (void)setupBtnTitle:(UIButton *)button count:(NSInteger)count defaultTitle:(NSString *)defaultTitle
{
    if (count >= 10000) { // [10000, 无限大)
        defaultTitle = [NSString stringWithFormat:@"%.1f万 %@", count / 10000.0, defaultTitle];
        // 用空串替换掉所有的.0
        defaultTitle = [defaultTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
    } else if (count > 0) { // (0, 10000)
        defaultTitle = [NSString stringWithFormat:@"%ld %@", count, defaultTitle];
    } else {
        defaultTitle = [NSString stringWithFormat:@"0 %@", defaultTitle];
    }
    [button setTitle:defaultTitle forState:UIControlStateNormal];
    [button setTitle:defaultTitle forState:UIControlStateSelected];
}
@end

