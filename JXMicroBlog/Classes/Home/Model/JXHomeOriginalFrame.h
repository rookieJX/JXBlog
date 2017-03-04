//
//  JXHomeOriginalFrame.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/21.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JXStatus;

@interface JXHomeOriginalFrame : NSObject

/** 昵称 */
@property (nonatomic,assign) CGRect nameFrame;
/** 内容 */
@property (nonatomic,assign) CGRect contentFrame;
/** 头像 */
@property (nonatomic,assign) CGRect iconFrame;
/** 会员 */
@property (nonatomic,assign) CGRect vipFrame;
/** 配图 */
@property (nonatomic,assign) CGRect photosFrame;


/** 原创微博 */
@property (nonatomic,assign) CGRect originFrame;


/** 原创微博 */
@property (nonatomic,strong) JXStatus * originalStatus;
@end
