//
//  JXHTTPTool.h
//  JXWeiBo
//
//  Created by 王加祥 on 16/6/27.
//  Copyright © 2016年 Wangjiaxiang. All rights reserved.
//  对网络请求的再次封装:负责整个项目的HTTP请求

#import <Foundation/Foundation.h>



@interface JXHTTPTool : NSObject

/**
 *  对GET请求的再次封装
 *
 *  @param url      请求接口
 *  @param params   请求参数
 *  @param progress 请求进度
 *  @param success  成功之后返回（请将请求成功后想做的事情写到这个block中）
 *  @param failure  失败之后返回（请将请求成功后想做的事情写到这个block中）
 */
+ (void)GET:(NSString *)url
     params:(NSDictionary *)params
   progress:(void (^)(NSProgress *progress))progress
    success:(void (^)(id responseObj))success
    failure:(void (^)(NSError * error))failure;

/**
 *  对POST请求的再次封装
 *
 *  @param url      请求接口
 *  @param params   请求参数
 *  @param progress 请求进度
 *  @param success  成功
 *  @param failure  失败
 */
+ (void)POST:(NSString *)url
      params:(NSDictionary *)params
    progress:(void (^)(NSProgress *progress))progress
     success:(void (^)(id responseObj))success
     failure:(void (^)(NSError * error))failure;

+ (void)POST:(NSString *)url
      params:(NSDictionary *)params constructingBodyWithData:(NSData *)data
    progress:(void (^)(NSProgress *progress))progress
     success:(void (^)(id responseObj))success
     failure:(void (^)(NSError * error))failure;

@end
