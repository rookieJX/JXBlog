//
//  JXAccountTool.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/13.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JXOAuthGetTokenParams.h" // 获取token参数

@class JXAccount;


@interface JXAccountTool : NSObject

/**
 *  读取账号信息
 */
+ (JXAccount *)account;


/**
 *  存储账号信息
 */
+ (void)saveAccount:(JXAccount *)account;

/**
 *  移除用户本地信息
 */
+ (void)removeAccount;

// 获取token
+ (void)getTokenWithParams:(JXOAuthGetTokenParams *)params success:(void (^)(JXAccount * account))success failure:(void (^)(NSError *error))failure;
@end
