//
//  JXEmotionPopView.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/3.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXEmotionPopView.h"
#import "JXEmotionView.h" // 弹出表情
#import "HMEmotion.h"

@interface JXEmotionPopView ()
/** 弹出表情 */
@property (nonatomic,weak) JXEmotionView * emotionView;
@end

@implementation JXEmotionPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"emoticon_keyboard_magnifier"]];
        [self addSubview:imageView];
        self.backgroundColor = [UIColor clearColor];
        
        self.w = imageView.w;
        self.h = imageView.h;
        
        JXEmotionView *emotionView = [[JXEmotionView alloc] init];
        [imageView addSubview:emotionView];
        self.emotionView = emotionView;
    }
    return self;
}

- (void)showEmotionFromEmotionView:(JXEmotionView *)emotionView {
    
    if (emotionView == nil) return;
    
    self.emotionView.emotion = emotionView.emotion;
    
    UIWindow *keyWindow = [[UIApplication sharedApplication].windows lastObject];
    [keyWindow addSubview:self];
    
    // 坐标系
    CGFloat centerX = emotionView.centerX;
    CGFloat centerY = emotionView.centerY - self.h * 0.5;
    CGPoint center = CGPointMake(centerX, centerY);
    
    self.center = [keyWindow convertPoint:center fromView:emotionView.superview];
}


#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.emotionView.frame = CGRectMake(15, 15, 34, 34);
    
}

@end
