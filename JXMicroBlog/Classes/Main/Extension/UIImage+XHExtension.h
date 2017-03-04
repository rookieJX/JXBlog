//
//  UIImage+XHExtension.h
//  XHMarket
//
//  Created by 王加祥 on 16/7/23.
//  Copyright © 2016年 HYCM. All rights reserved.
//  封装图片扩展

#import <UIKit/UIKit.h>

@interface UIImage (XHExtension)

/**
 *  可以获得图片为原图，不需要系统渲染
 *
 *  @param imageName 图片名称
 *
 *  @return 返回原始图片
 */
+ (UIImage *)originalImageWithImageName:(NSString *)imageName;

/**
 *  根据图片名返回自由拉伸的图片
 *
 *  @param imageName 图片名
 *
 *  @return 拉伸后的图片
 */
+ (UIImage *)resizedImage:(NSString *)imageName;

@end
