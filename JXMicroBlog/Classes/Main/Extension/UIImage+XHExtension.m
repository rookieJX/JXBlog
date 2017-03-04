//
//  UIImage+XHExtension.m
//  XHMarket
//
//  Created by 王加祥 on 16/7/23.
//  Copyright © 2016年 HYCM. All rights reserved.
//

#import "UIImage+XHExtension.h"

@implementation UIImage (XHExtension)


+ (UIImage *)originalImageWithImageName:(NSString *)imageName {
    
    UIImage * image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

+ (UIImage *)resizedImage:(NSString *)imageName {
    
    UIImage * image = [UIImage originalImageWithImageName:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5
                                      topCapHeight:image.size.height * 0.5];
    
}

@end
