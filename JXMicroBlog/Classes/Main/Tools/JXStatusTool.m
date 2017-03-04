//
//  JXStatusTool.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/19.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXStatusTool.h"
#import "JXHTTPTool.h"

@implementation JXStatusTool
+ (void)homeStatusWithParams:(JXHomeParams *)params success:(void (^)(JXHomeStatusResultModel *))success failure:(void (^)(NSError *))failure {
    [JXHTTPTool GET:kHomeTimeLineUrl params:params.mj_keyValues progress:nil success:^(NSDictionary * responseObj) {
        JXHomeStatusResultModel *resultModel = [JXHomeStatusResultModel mj_objectWithKeyValues:responseObj];
        if (success) {
            success(resultModel);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

+ (void)userInfoWithParams:(JXShowUserParams *)params success:(void (^)(JXUserModel *))success failure:(void (^)(NSError *))failure {
    [JXHTTPTool GET:kHomeShowUserUrl params:params.mj_keyValues progress:nil success:^(NSDictionary * responseObj) {
        JXUserModel *user = [JXUserModel mj_objectWithKeyValues:responseObj];
        if (success) {
            success(user);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)unreadeCountWithParams:(JXHomeUnreadeCountParam *)params success:(void (^)(JXHomeUnreadeCountModel *))success failure:(void (^)(NSError *))failure {
    [JXHTTPTool GET:kUnreadeCountUrl params:params.mj_keyValues progress:nil success:^(NSDictionary * responseObj) {
        JXHomeUnreadeCountModel *user = [JXHomeUnreadeCountModel mj_objectWithKeyValues:responseObj];
        if (success) {
            success(user);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
