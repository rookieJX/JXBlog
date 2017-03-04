//
//  JXHomeStatusPhotoView.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/26.
//  Copyright © 2017年 王加祥. All rights reserved.
//  配图

#import <UIKit/UIKit.h>

@class JXPhoto;

@interface JXHomeStatusPhotoView : UIImageView
/** 图片 */
@property (nonatomic,strong) JXPhoto * photo;
@end
