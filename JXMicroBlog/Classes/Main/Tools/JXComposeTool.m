

//
//  JXComposeTool.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/19.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXComposeTool.h"

@implementation JXComposeTool

+ (void)composeWithOutPhotoStatusWithParams:(JXSendStatusWithOutPhotoParams *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [JXHTTPTool POST:kSendWithOutPhoto params:params.mj_keyValues progress:nil success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)composeWithPhotoStatusWithParams:(JXSendStatusWithOutPhotoParams *)params imageData:(NSData *)data success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [JXHTTPTool POST:kSendWithPhoto params:params.mj_keyValues constructingBodyWithData:data progress:nil success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
