//
//  JXTitleButton.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2016/12/25.
//  Copyright © 2016年 王加祥. All rights reserved.
//  自定义首页按钮

#import "JXTitleButton.h"

@implementation JXTitleButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}
// 修改按钮文字位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleX = 0.0f;
    CGFloat titleY = 0.0f;
    CGFloat titleW = self.w - self.h;
    CGFloat titleH = self.h;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageH = self.h;
    CGFloat imageW = self.h;
    CGFloat imageX = self.w - self.h;
    CGFloat imageY = 0;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    
    // 1.计算文字的尺寸
    // 设置属性
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = self.titleLabel.font;
    
    CGSize titleSize = [title sizeWithAttributes:dict];
    
    // 2.计算按钮的宽度
    self.w = titleSize.width + self.h + 10;

}
@end
