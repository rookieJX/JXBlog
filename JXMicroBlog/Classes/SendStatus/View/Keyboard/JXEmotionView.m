//
//  JXEmotionView.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/2.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXEmotionView.h"
#import "HMEmotion.h"


@implementation JXEmotionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (void)setEmotion:(HMEmotion *)emotion {
    _emotion = emotion;
    
    if (emotion.code) {
        
        [UIView setAnimationsEnabled:NO];
        self.titleLabel.font = [UIFont systemFontOfSize:30.0f];
        [self setTitle:emotion.emoji forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView setAnimationsEnabled:YES];
        });
    } else {
        NSString *iconName = [NSString stringWithFormat:@"%@/%@",emotion.floder,emotion.png];
        [self setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
    }
    
}

@end
