//
//  JXStatusTool.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/19.
//  Copyright © 2017年 王加祥. All rights reserved.
//  微博业务类,请求微博

#import <Foundation/Foundation.h>
#import "JXHomeParams.h" // 请求首页模型参数
#import "JXHomeStatusResultModel.h" // 首页模型
#import "JXShowUserParams.h" // 请求个人信息模型参数
#import "JXUserModel.h" // 用户信息模型
#import "JXHomeUnreadeCountParam.h" // 请求未读消息模型参数
#import "JXHomeUnreadeCountModel.h" // 未读消息模型

@interface JXStatusTool : NSObject

// 加载首页最新微博数据
+ (void)homeStatusWithParams:(JXHomeParams *)params success:(void (^)(JXHomeStatusResultModel *homeStatus))success failure:(void (^)(NSError *error))failure;

// 获取用户个人信息
+ (void)userInfoWithParams:(JXShowUserParams *)params success:(void (^)(JXUserModel *homeStatus))success failure:(void (^)(NSError *error))failure;

// 获取未读个数
+ (void)unreadeCountWithParams:(JXHomeUnreadeCountParam *)params success:(void (^)(JXHomeUnreadeCountModel *homeStatus))success failure:(void (^)(NSError *error))failure;

@end
