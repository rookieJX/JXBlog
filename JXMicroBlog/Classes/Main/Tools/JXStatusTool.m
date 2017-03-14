//
//  JXStatusTool.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/19.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXStatusTool.h"
#import "JXHTTPTool.h"
#import "FMDB.h"
#import "JXStatus.h"

@implementation JXStatusTool

// 数据库实例
static FMDatabase  *_db;

+ (void)initialize {
    // 1.获得数据库文件的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filename = [doc stringByAppendingPathComponent:@"status.sqlite"];
    
    // 2.得到数据库
    _db = [FMDatabase databaseWithPath:filename];
    
    // 3.打开数据库
    if ([_db open]) {
        // 4.创表
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_home_status (id integer PRIMARY KEY AUTOINCREMENT, access_token text NOT NULL, status_idstr text NOT NULL, status_dict blob NOT NULL);"];
        if (result) {
            JXLog(@"成功创表");
        } else {
            JXLog(@"创表失败");
        }
    }
}

+ (void)homeStatusWithParams:(JXHomeParams *)params success:(void (^)(JXHomeStatusResultModel *))success failure:(void (^)(NSError *))failure {
    // 从数据库中读取（加载）缓存数据(微博模型数组)
    NSArray *cachedHomeStatuses = [self cachedHomeStatusesWithParam:params];
    if (cachedHomeStatuses.count != 0) { // 有缓存数据
        if (success) {
            JXHomeStatusResultModel *result = [[JXHomeStatusResultModel alloc] init];
            result.statuses = cachedHomeStatuses;
            success(result);
        }
    } else {
        [JXHTTPTool GET:kHomeTimeLineUrl params:params.mj_keyValues progress:nil success:^(NSDictionary * responseObj) {
            JXHomeStatusResultModel *resultModel = [JXHomeStatusResultModel mj_objectWithKeyValues:responseObj];
            // 新浪返回的字典数组
            NSArray *statusDictArray = responseObj[@"statuses"];
            
            // 缓存微博字典数组
            [self saveHomeStatusDictArray:statusDictArray accessToken:params.access_token];

            if (success) {
                success(resultModel);
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }

}

/**
 *  通过请求参数去数据库中加载对应的微博数据
 *
 *  @param param 请求参数
 */
+ (NSArray *)cachedHomeStatusesWithParam:(JXHomeParams *)param
{
    // 创建数组缓存微博数据
    NSMutableArray *statuses = [NSMutableArray array];
    
    // 根据请求参数查询数据
    FMResultSet *resultSet = nil;
    if (param.since_id) {
        resultSet = [_db executeQuery:@"SELECT * FROM t_home_status WHERE access_token = ? AND status_idstr > ? ORDER BY status_idstr DESC limit ?;", param.access_token, @(param.since_id), @(param.count)];
    } else if (param.max_id) {
        resultSet = [_db executeQuery:@"SELECT * FROM t_home_status WHERE access_token = ? AND status_idstr <= ? ORDER BY status_idstr DESC limit ?;", param.access_token, @(param.max_id), @(param.count)];
    } else {
        resultSet = [_db executeQuery:@"SELECT * FROM t_home_status WHERE access_token = ? ORDER BY status_idstr DESC limit ?;", param.access_token, @(param.count)];
    }
    
    // 遍历查询结果
    while (resultSet.next) {
        NSData *statusDictData = [resultSet objectForColumnName:@"status_dict"];
        NSDictionary *statusDict = [NSKeyedUnarchiver unarchiveObjectWithData:statusDictData];
        // 字典转模型
        JXStatus *status = [JXStatus mj_objectWithKeyValues:statusDict];
        // 添加模型到数组中
        [statuses addObject:status];
    }
    
    return statuses;
}


/**
 *  缓存微博字典数组到数据库中
 */
+ (void)saveHomeStatusDictArray:(NSArray *)statusDictArray accessToken:(NSString *)accessToken
{
    for (NSDictionary *statusDict in statusDictArray) {
        // 把statusDict字典对象序列化成NSData二进制数据
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:statusDict];
        [_db executeUpdate:@"INSERT INTO t_home_status (access_token, status_idstr, status_dict) VALUES (?, ?, ?);",
         accessToken, statusDict[@"idstr"], data];
    }
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

+ (void)detailCountWithParams:(JXHomeStatusDetailParams *)params success:(void (^)(JXHomeStatusDetailResult *))success failure:(void (^)(NSError *))failure {
    
    [JXHTTPTool GET:kHomeDetailUrl params:params.mj_keyValues progress:nil success:^(NSDictionary * responseObj) {
        JXHomeStatusDetailResult *detail = [JXHomeStatusDetailResult mj_objectWithKeyValues:responseObj];
        if (success) {
            success(detail);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
