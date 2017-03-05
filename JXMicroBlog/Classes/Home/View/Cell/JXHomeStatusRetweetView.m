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

@interface JXHomeStatusRetweetView ()
/** 昵称 */
@property (nonatomic,weak) UIButton * nameButton;
/** 内容 */
@property (nonatomic,weak) UILabel * contentLabel;
/** 配图 */
@property (nonatomic,weak) JXHomeStatusPhotosView * photosView;
@end

@implementation JXHomeStatusRetweetView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kRGBColor(238, 238, 238, 1.0);
        // 创建昵称
        UIButton *nameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:nameButton];
        self.nameButton = nameButton;
        self.nameButton.titleLabel.font = kHomeRetweetNameFont;
        [self.nameButton setTitleColor:kRGBColor(74, 102, 105, 1.0) forState:UIControlStateNormal];
        
        // 创建内容
        UILabel *contentLabel = [[UILabel alloc] init];
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        self.contentLabel.font = kHomeRetweetContenFont;
        self.contentLabel.numberOfLines = 0;
        
        // 创建配图
        JXHomeStatusPhotosView *photosView = [[JXHomeStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
    }
    return self;
}

- (void)setRetweetFrame:(JXHomeRetweetFrame *)retweetFrame {
    _retweetFrame = retweetFrame;
    
    self.frame = retweetFrame.retweetFrame;
    
    JXUserModel *user = retweetFrame.retweetStatus.user;
    
    NSString *name = [NSString stringWithFormat:@"@%@",user.name];
    [self.nameButton setTitle:name forState:UIControlStateNormal];
    self.nameButton.frame = retweetFrame.nameFrame;
    
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
    
}




@end
