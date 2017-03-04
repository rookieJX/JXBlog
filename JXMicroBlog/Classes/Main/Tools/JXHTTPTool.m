//
//  JXHTTPTool.m
//  JXWeiBo
//
//  Created by 王加祥 on 16/6/27.
//  Copyright © 2016年 Wangjiaxiang. All rights reserved.
//  封装网络接口

#import "JXHTTPTool.h"
#import "AFNetworking.h"


@implementation JXHTTPTool

+(void)GET:(NSString *)url
    params:(NSDictionary *)params
  progress:(void (^)(NSProgress *))progress
   success:(void (^)(id))success
   failure:(void (^)(NSError *))failure {
    // 1.获得请求管理者
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    // 创建GET请求
    if (!url) url = @"";
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}



+ (void)POST:(NSString *)url
      params:(NSDictionary *)params
    progress:(void (^)(NSProgress *))progress
     success:(void (^)(id))success
     failure:(void (^)(NSError *))failure {
    // 1.获得请求管理者
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    if (!url) url = @"";
    // 创建POST请求
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

}

+ (void)POST:(NSString *)url
      params:(NSDictionary *)params constructingBodyWithData:(NSData *)data
    progress:(void (^)(NSProgress *))progress
     success:(void (^)(id))success
     failure:(void (^)(NSError *))failure {
    // 1.获得请求管理者
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    if (!url) url = @"";
    [manager POST:url
       parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
           if (data) {
               [formData appendPartWithFileData:data name:@"pic" fileName:@"status.jpg" mimeType:@"image/jpeg"];
               
           }
       } progress:^(NSProgress * _Nonnull uploadProgress) {
           if (progress) {
               progress(uploadProgress);
           }
       } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           if (success) {
               success(responseObject);
           }
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           if (failure) {
               failure(error);
           }
       }];
}



@end
