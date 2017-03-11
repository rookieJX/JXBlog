//
//  JXHomeRetweetFrame.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/21.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JXStatus;

@interface JXHomeRetweetFrame : NSObject

/** 内容 */
@property (nonatomic,assign) CGRect contentFrame;
/** 配图 */
@property (nonatomic,assign) CGRect photosFrame;
/** 工具条 */
@property (nonatomic,assign) CGRect toolbarFrame;

/** 转发微博frame */
@property (nonatomic,assign) CGRect retweetFrame;

/** 转发微博 */
@property (nonatomic,strong) JXStatus * retweetStatus;

@end
