//
//  JXComposePhotoView.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/18.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXComposePhotoView.h"

@implementation JXComposePhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)addImage:(UIImage *)image {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.image = image;
    [self addSubview:imageView];
}

#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    
    NSInteger maxCol = 4;
    
    CGFloat margin = 10.0f;
    CGFloat width = (self.w - (maxCol + 1) * margin) / maxCol;
    CGFloat height = width;
    
    for (NSInteger i=0; i<count; i++) {
        
        NSInteger row = i / maxCol;
        
        NSInteger col = i % maxCol;
        
        UIImageView *imageView = self.subviews[i];
        imageView.w = width;
        imageView.h = height;
        imageView.x = margin + (width + margin) * col;
        imageView.y = row * ( height + margin);
        
    }
}

- (NSArray *)images {
    NSMutableArray *array = [NSMutableArray array];
    for (UIImageView *imageView in self.subviews) {
        [array addObject:imageView.image];
    }
    return array;
}
@end
