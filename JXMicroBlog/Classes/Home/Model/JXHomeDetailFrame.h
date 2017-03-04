//
//  JXHomeDetailFrame.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/22.
//  Copyright © 2017年 王加祥. All rights reserved.
//  详细控制器

#import <Foundation/Foundation.h>


@class JXStatus,JXHomeOriginalFrame,JXHomeRetweetFrame;

@interface JXHomeDetailFrame : NSObject

/** 原创微博 */
@property (nonatomic,strong) JXHomeOriginalFrame * originalFrame;
/** 转发微博 */
@property (nonatomic,strong) JXHomeRetweetFrame * retweetFrame;
/** 整体Frame */
@property (nonatomic,assign) CGRect detailFrame;
/** 微博模型 */
@property (nonatomic,strong) JXStatus * status;
@end
