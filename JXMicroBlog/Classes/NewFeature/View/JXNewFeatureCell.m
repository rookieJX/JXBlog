//
//  JXNewFeatureCell.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/9.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXNewFeatureCell.h"

@interface JXNewFeatureCell ()
/** 新特性 */
@property (nonatomic,weak) UIImageView * featureImageView;

@end

@implementation JXNewFeatureCell



- (void)setFeatureName:(NSString *)featureName {
    _featureName = featureName;
    self.featureImageView.image = [UIImage imageNamed:featureName];
}

#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    self.featureImageView.frame = self.bounds;
}
// 新特性图片
- (UIImageView *)featureImageView{
    if (_featureImageView == nil) {
        UIImageView *featureImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:featureImageView];
        _featureImageView = featureImageView;
    }
    return _featureImageView;
}
@end
