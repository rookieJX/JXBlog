//
//  JXHomeDetailFrame.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/22.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXHomeDetailFrame.h"
#import "JXStatus.h"
#import "JXHomeOriginalFrame.h" // 原创微博
#import "JXHomeRetweetFrame.h" // 转发微博

@implementation JXHomeDetailFrame
- (void)setStatus:(JXStatus *)status {
    _status = status;
    
    // 计算原创微博
    self.originalFrame = [[JXHomeOriginalFrame alloc] init];
    self.originalFrame.originalStatus = status;
    
    // 计算转发微博
    CGFloat h = 0;
    if (status.retweeted_status) {
        self.retweetFrame = [[JXHomeRetweetFrame alloc] init];
        self.retweetFrame.retweetStatus = status.retweeted_status;
        // 计算frame
        CGRect frame = self.retweetFrame.retweetFrame;
        frame.origin.y = CGRectGetMaxY(self.originalFrame.originFrame);
        self.retweetFrame.retweetFrame = frame;
        h = CGRectGetMaxY(self.retweetFrame.retweetFrame);
    } else {
        h = CGRectGetMaxY(self.originalFrame.originFrame);
    }
    // 计算自己的frame
    CGFloat x = 0;
    CGFloat y = 10;
    CGFloat w = kWidth;
    
    self.detailFrame = CGRectMake(x, y, w, h);
}
@end
