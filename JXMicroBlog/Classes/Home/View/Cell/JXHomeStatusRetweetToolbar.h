//
//  JXHomeStatusRetweetToolbar.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/11.
//  Copyright © 2017年 王加祥. All rights reserved.
//  详细转发微博

#import <UIKit/UIKit.h>

@class JXStatus;

@interface JXHomeStatusRetweetToolbar : UIView
/** 微博 */
@property (nonatomic,strong) JXStatus * status;
@end
