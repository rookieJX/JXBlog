//
//  JXBageView.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/11.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXBageView.h"

@implementation JXBageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage resizedImage:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        self.h = self.currentBackgroundImage.size.height;
    }
    return self;
}

- (void)setBageVaule:(NSString *)bageVaule {
    _bageVaule = [bageVaule copy];
    
    [self setTitle:bageVaule forState:UIControlStateNormal];
    
    CGSize size = [bageVaule sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    CGFloat bgW = self.currentBackgroundImage.size.width;
    if (bgW > size.width) {
        self.w = bgW;
    } else {
        self.w = size.width + 10;
    }
    
    
}


@end
