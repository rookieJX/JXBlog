//
//  JXComposePhotoView.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/18.
//  Copyright © 2017年 王加祥. All rights reserved.
//  存放图片

#import <UIKit/UIKit.h>

@interface JXComposePhotoView : UIView

- (void)addImage:(UIImage *)image;

- (NSArray *)images;
@end
