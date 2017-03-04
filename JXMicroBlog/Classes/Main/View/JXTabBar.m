//
//  JXTabBar.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/7.
//  Copyright © 2017年 王加祥. All rights reserved.
//  自定义UITabBar

#import "JXTabBar.h"

@interface JXTabBar ()
/** 按钮 */
@property (nonatomic,weak) UIButton * plusButton;
@end

@implementation JXTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton addTarget:self
                       action:@selector(plusButtonClick) forControlEvents:UIControlEventTouchUpInside];
        plusButton.adjustsImageWhenHighlighted = NO;
        [self addSubview:plusButton];
        self.plusButton = plusButton;
    }
    return self;
}


- (void)plusButtonClick {
    if (self.CenterBtnClickBlock) {
        self.CenterBtnClickBlock();
    }
}

#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = self.w / 5;
    CGFloat h = self.h;
    
    int index = 0;
    
    for (UIView *tabBarView in self.subviews) {
        if (![tabBarView isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        tabBarView.w = w;
        tabBarView.h = h;
        tabBarView.y = 0;
        tabBarView.x = w * index;
        
        if (index >= 2) {
            tabBarView.x += w;
        }
        
        index ++;
    }
    
    // 中间按钮尺寸
    self.plusButton.size = CGSizeMake(w, h);
    self.plusButton.centerX = self.w * 0.5;
    self.plusButton.centerY = self.h * 0.5;
}

@end
