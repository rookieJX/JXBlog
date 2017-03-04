//
//  JXHomeStatusFrame.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/21.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXHomeStatusFrame.h"
#import "JXStatus.h"
#import "JXHomeDetailFrame.h"


@implementation JXHomeStatusFrame

- (void)setStauts:(JXStatus *)stauts {
    _stauts = stauts;
    
    [self setupDetailFrame];
    
    [self setupToolbarFrame];
    
    // 计算cell高度
    self.cellHeight = CGRectGetMaxY(self.toolbarFrame);
    
}


// 计算整体微博
- (void)setupDetailFrame {
    self.detailFrame = [[JXHomeDetailFrame alloc] init];
    self.detailFrame.status = self.stauts; 
}

// 计算底部工具条
- (void)setupToolbarFrame {
    CGFloat toolbarX = 0;
    CGFloat toolbarY = CGRectGetMaxY(self.detailFrame.detailFrame);
    CGFloat toolbarW = kWidth;
    CGFloat toolbarH = 40;
    self.toolbarFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
}
@end
