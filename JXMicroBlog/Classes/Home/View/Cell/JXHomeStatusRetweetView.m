//
//  JXHomeStatusRetweetView.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/20.
//  Copyright © 2017年 王加祥. All rights reserved.
//  首页转发微博

#import "JXHomeStatusRetweetView.h"
#import "JXHomeRetweetFrame.h"
#import "JXStatus.h"
#import "JXUserModel.h"
#import "JXHomeStatusPhotosView.h" // 配图
#import "JXStatusLabel.h" // 自定义Label
#import "JXHomeStatusRetweetToolbar.h"

@interface JXHomeStatusRetweetView ()
/** 内容 */
@property (nonatomic,weak) JXStatusLabel * contentLabel;
/** 配图 */
@property (nonatomic,weak) JXHomeStatusPhotosView * photosView;
/** 工具条 */
@property (nonatomic,weak) JXHomeStatusRetweetToolbar * toolbar;
@end

@implementation JXHomeStatusRetweetView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kRGBColor(238, 238, 238, 1.0);

        // 创建内容
        JXStatusLabel *contentLabel = [[JXStatusLabel alloc] init];
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        // 创建配图
        JXHomeStatusPhotosView *photosView = [[JXHomeStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
        
        // 工具条
        JXHomeStatusRetweetToolbar * toolbar = [[JXHomeStatusRetweetToolbar alloc] init];
        [self addSubview:toolbar];
        self.toolbar = toolbar;
    }
    return self;
}

- (void)setRetweetFrame:(JXHomeRetweetFrame *)retweetFrame {
    _retweetFrame = retweetFrame;
    
    self.frame = retweetFrame.retweetFrame;
    
    self.contentLabel.attributedText = retweetFrame.retweetStatus.attributeText;
    self.contentLabel.frame = retweetFrame.contentFrame;
    
    // 配图
    if (retweetFrame.retweetStatus.pic_urls.count) {
        self.photosView.hidden = NO;
        self.photosView.frame = retweetFrame.photosFrame;
        self.photosView.pic_urls = retweetFrame.retweetStatus.pic_urls;
    } else {
        self.photosView.hidden = YES;
    }
    
    if (retweetFrame.retweetStatus.isDetail) {
        self.toolbar.hidden = NO; 
        self.toolbar.frame = retweetFrame.toolbarFrame;
        self.toolbar.status = retweetFrame.retweetStatus;
    } else {
        self.toolbar.hidden = YES;
    }
    
}




@end
