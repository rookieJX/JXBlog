//
//  JXHomeStatusOriginalView.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/20.
//  Copyright © 2017年 王加祥. All rights reserved.
//  首页原创微博

#import "JXHomeStatusOriginalView.h"
#import "JXHomeOriginalFrame.h"
#import "JXStatus.h"
#import "JXUserModel.h"
#import "JXHomeStatusPhotosView.h" // 配图

@interface JXHomeStatusOriginalView ()
/** 昵称 */
@property (nonatomic,weak) UIButton * nameButton;
/** 内容 */
@property (nonatomic,weak) UILabel * contentLabel;
/** 时间 */
@property (nonatomic,weak) UILabel * timeLabel;
/** 来源 */
@property (nonatomic,weak) UILabel * sourceLabel;
/** 头像 */
@property (nonatomic,weak) UIImageView * iconImageView;
/** 会员 */
@property (nonatomic,weak) UIImageView * vipImageView;
/** 配图 */
@property (nonatomic,weak) JXHomeStatusPhotosView * photosView;
@end

@implementation JXHomeStatusOriginalView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 创建昵称
        UIButton *nameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:nameButton];
        self.nameButton = nameButton;
        self.nameButton.titleLabel.font = kHomeOriginalNameFont;
        [self.nameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        // 创建内容
        UILabel *contentLabel = [[UILabel alloc] init];
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        self.contentLabel.font = kHomeOriginalContentFont;
        self.contentLabel.numberOfLines = 0;
        
        // 创建时间
        UILabel *timeLabel = [[UILabel alloc] init];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        timeLabel.textColor = [UIColor orangeColor];
        self.timeLabel.font = kHomeOriginalTimeFont;
        
        // 创建来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        self.sourceLabel.textColor = [UIColor lightGrayColor];
        self.sourceLabel.font = kHomeOriginalSourceFont;
        
        // 创建头像
        UIImageView *iconImageView = [[UIImageView alloc] init];
        [self addSubview:iconImageView];
        self.iconImageView = iconImageView;
        
        // 创建会员
        UIImageView *vipImageView = [[UIImageView alloc] init];
        [self addSubview:vipImageView];
        vipImageView.contentMode = UIViewContentModeCenter;
        self.vipImageView = vipImageView;
        
        // 创建配图
        JXHomeStatusPhotosView *photosView = [[JXHomeStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
    }
    return self;
}

- (void)setOriginalFrame:(JXHomeOriginalFrame *)originalFrame {
    _originalFrame = originalFrame;
    
    self.frame = originalFrame.originFrame;
    
    JXUserModel *user = originalFrame.originalStatus.user;
    
    
    [self.nameButton setTitle:user.name forState:UIControlStateNormal];
    self.nameButton.frame = originalFrame.nameFrame;
    if (user.isVip) {
        self.vipImageView.hidden = NO;
        self.vipImageView.frame = originalFrame.vipFrame;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%ld",user.mbrank];
        self.vipImageView.image = [UIImage imageNamed:vipName ];
        [self.nameButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    } else {
        self.vipImageView.hidden = YES;
        [self.nameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    self.contentLabel.attributedText = originalFrame.originalStatus.attributeText;
    self.contentLabel.frame = originalFrame.contentFrame;
    
    self.timeLabel.text = originalFrame.originalStatus.created_at;
    // 时间
    CGFloat timeX = CGRectGetMinX(originalFrame.nameFrame);
    CGFloat timeY = CGRectGetMaxY(originalFrame.nameFrame) + kHomeCellMargin * 0.3;
    NSMutableDictionary *timeDict = [NSMutableDictionary dictionary];
    timeDict[NSFontAttributeName] = kHomeOriginalTimeFont;
    NSString *time = [NSString stringWithFormat:@"%@  ",originalFrame.originalStatus.created_at];
    CGSize timeSize = [time sizeWithAttributes:timeDict];
    self.timeLabel.frame = (CGRect){{timeX,timeY},timeSize};
    
    self.sourceLabel.text = originalFrame.originalStatus.source;
    // 来源
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + kHomeCellMargin;
    CGFloat sourceY = timeY;
    NSMutableDictionary *sourceDict = [NSMutableDictionary dictionary];
    sourceDict[NSFontAttributeName] = kHomeOriginalSourceFont;
    CGSize sourceSize = [originalFrame.originalStatus.source sizeWithAttributes:sourceDict];
    self.sourceLabel.frame = (CGRect){{sourceX,sourceY},sourceSize};
    
    self.iconImageView.frame = originalFrame.iconFrame;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    // 配图
    if (originalFrame.originalStatus.pic_urls.count) {
        self.photosView.hidden = NO;
        self.photosView.frame = originalFrame.photosFrame;
        self.photosView.pic_urls = originalFrame.originalStatus.pic_urls;
    } else {
        self.photosView.hidden = YES;
    }
    
    
}



@end
