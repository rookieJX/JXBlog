//
//  JXPopView.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/7.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXPopView.h"

@interface JXPopView ()
/** 整个容器 */
@property (nonatomic,weak) UIButton * coverButton;
/** 需要显示弹出的视图 */
@property (nonatomic,weak) UIView * popView;
@end

@implementation JXPopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.coverButton addTarget:self
                             action:@selector(dismiss)
                   forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype)initWithPopView:(UIView *)view {
    self = [super init];
    if (self) {
        self.popView = view;
    }
    return self;
}

- (void)showPopViewRect:(CGRect)rect {
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    
    self.popView.frame = rect;
    [self addSubview:self.popView];
}
// 退出
- (void)dismiss {
    [self removeFromSuperview];
}

- (UIButton *)coverButton{
    if (_coverButton == nil) {
        UIButton *coverButton = [UIButton buttonWithType:UIButtonTypeCustom];
        coverButton.frame = kScreen;
        coverButton.backgroundColor = [UIColor clearColor];
        [self addSubview:coverButton];
        _coverButton = coverButton;
    }
    return _coverButton;
}
@end
