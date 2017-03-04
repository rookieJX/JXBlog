//
//  JXHomeOriginalFrame.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/21.
//  Copyright © 2017年 王加祥. All rights reserved.
//  原创微博

#import "JXHomeOriginalFrame.h"
#import "JXStatus.h"
#import "JXUserModel.h"
#import "JXHomeStatusPhotosView.h"

@implementation JXHomeOriginalFrame
- (void)setOriginalStatus:(JXStatus *)originalStatus {
    _originalStatus = originalStatus;
    
    // 计算头像
    CGFloat iconX = kHomeCellMargin;
    CGFloat iconY = kHomeCellMargin;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 昵称
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + kHomeCellMargin;
    CGFloat nameY = iconY;
    NSMutableDictionary *nameDict = [NSMutableDictionary dictionary];
    nameDict[NSFontAttributeName] = kHomeOriginalNameFont;
    CGSize nameSize = [originalStatus.user.name sizeWithAttributes:nameDict];
    self.nameFrame = (CGRect){{nameX,nameY},nameSize};
    
    // 会员
    if (originalStatus.user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameFrame) + kHomeCellMargin;
        CGFloat vipY = iconY;
        CGFloat vipW = nameSize.height;
        CGFloat vipH = nameSize.height;
        self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    // 正文
    CGFloat contentX = iconX;
    CGFloat contentY = CGRectGetMaxY(self.iconFrame) + kHomeCellMargin;
    
    CGFloat contentMaxW = kWidth - 2 * contentX;
    CGSize contenSize = CGSizeMake(contentMaxW, MAXFLOAT);
    
    CGSize contentRectSize = [originalStatus.text boundingRectWithSize:contenSize
                                                               options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                            attributes:@{NSFontAttributeName:kHomeOriginalContentFont}
                                                               context:nil].size;
    self.contentFrame = (CGRect){{contentX,contentY},contentRectSize};
    
    // 配图
    CGFloat h = 0;
    if (originalStatus.pic_urls.count) {
        CGFloat photosX = contentX;
        CGFloat photosY = CGRectGetMaxY(self.contentFrame) + kHomeCellMargin;
        CGSize photosSize = [JXHomeStatusPhotosView sizeWithPhotosCount:originalStatus.pic_urls.count];
        self.photosFrame =  (CGRect){{photosX,photosY},photosSize};
        h = CGRectGetMaxY(self.photosFrame) + kHomeCellMargin;
    } else {
        h = CGRectGetMaxY(self.contentFrame) + kHomeCellMargin;
    }

    // 自己的frame
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = kWidth;
    self.originFrame = CGRectMake(x, y, w, h);
    
}
@end
