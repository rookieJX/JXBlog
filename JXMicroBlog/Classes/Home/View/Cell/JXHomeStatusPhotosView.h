//
//  JXHomeStatusPhotosView.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/26.
//  Copyright © 2017年 王加祥. All rights reserved.
//  配图相册

#import <UIKit/UIKit.h>

@interface JXHomeStatusPhotosView : UIView
/** 图片 */
@property (nonatomic,strong) NSArray * pic_urls;
// 根据配图个数来计算尺寸
+ (CGSize)sizeWithPhotosCount:(NSInteger)count;

@end
