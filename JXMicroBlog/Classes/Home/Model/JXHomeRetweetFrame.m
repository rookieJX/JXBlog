//
//  JXHomeRetweetFrame.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/21.
//  Copyright © 2017年 王加祥. All rights reserved.
//  转发微博尺寸

#import "JXHomeRetweetFrame.h"
#import "JXStatus.h"
#import "JXUserModel.h"
#import "JXHomeStatusPhotosView.h"

@implementation JXHomeRetweetFrame
- (void)setRetweetStatus:(JXStatus *)retweetStatus {
    _retweetStatus = retweetStatus;
    
    // 正文
    CGFloat contentX = kHomeCellMargin;
    CGFloat contentY = kHomeCellMargin;
    
    CGFloat contentMaxW = kWidth - 2 * contentX;
    CGSize contenSize = CGSizeMake(contentMaxW, MAXFLOAT);

                                                                                      
    CGSize contentRectSize = [retweetStatus.attributeText boundingRectWithSize:contenSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;;
    self.contentFrame = (CGRect){{contentX,contentY},contentRectSize};
    
    // 配图
    CGFloat toolbarY = 0;
    if (retweetStatus.pic_urls.count) {
        CGFloat photosX = contentX;
        CGFloat photosY = CGRectGetMaxY(self.contentFrame) + kHomeCellMargin;
        CGSize photosSize = [JXHomeStatusPhotosView sizeWithPhotosCount:retweetStatus.pic_urls.count];
        self.photosFrame =  (CGRect){{photosX,photosY},photosSize};
        toolbarY = CGRectGetMaxY(self.photosFrame) + kHomeCellMargin;
    } else {
        toolbarY = CGRectGetMaxY(self.contentFrame) + kHomeCellMargin;
    }
    
    // 工具条
    CGFloat toolbarW = kWidth/2;
    CGFloat toolbarX = kWidth - toolbarW;
    CGFloat toolbarH = 30;
    self.toolbarFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
    // 自己的frame
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = kWidth;
    CGFloat h = CGRectGetMaxY(self.toolbarFrame) + kHomeCellMargin;
    self.retweetFrame = CGRectMake(x, y, w, h);

}
@end
