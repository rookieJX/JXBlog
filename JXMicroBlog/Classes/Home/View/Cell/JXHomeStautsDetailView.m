//
//  JXHomeStautsDetailView.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/20.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXHomeStautsDetailView.h"
#import "JXHomeStatusOriginalView.h" // 原创
#import "JXHomeStatusRetweetView.h" // 转发
#import "JXHomeDetailFrame.h"

@interface JXHomeStautsDetailView ()
/** 原创 */
@property (nonatomic,weak) JXHomeStatusOriginalView *originalView;
/** 转发 */
@property (nonatomic,weak) JXHomeStatusRetweetView *retweetView;
@end

@implementation JXHomeStautsDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupOriginalView];
        [self setupRetweetView];
    }
    return self;
}


// 原创微博
- (void)setupOriginalView {
    JXHomeStatusOriginalView *originalView = [[JXHomeStatusOriginalView alloc] init];
    [self addSubview:originalView];
    self.originalView = originalView;
}

// 转发
- (void)setupRetweetView {
    JXHomeStatusRetweetView *retweetView = [[JXHomeStatusRetweetView alloc] init];
    [self addSubview:retweetView];
    self.retweetView = retweetView;
}

- (void)setDetailFrame:(JXHomeDetailFrame *)detailFrame {
    _detailFrame = detailFrame;
    
    self.frame = detailFrame.detailFrame;
    
    // 原创微博
    self.originalView.originalFrame = detailFrame.originalFrame;
    
    // 转发微博
    self.retweetView.retweetFrame = detailFrame.retweetFrame;
}
@end
