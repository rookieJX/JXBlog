//
//  JXAccountTool.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/13.
//  Copyright © 2017年 王加祥. All rights reserved.
//  账号工具类

#import "JXAccountTool.h"
#import "JXAccount.h"


#define JXAccountFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation JXAccountTool

+ (void)saveAccount:(JXAccount *)account {
    // 归档
    [NSKeyedArchiver archiveRootObject:account toFile:JXAccountFilePath];
    
}


+ (JXAccount *)account {
    // 接档
    JXAccount * account = [NSKeyedUnarchiver unarchiveObjectWithFile:JXAccountFilePath];
    // 检测授权是否过期（一般新浪授权测试账号只有一天，但是自己给自己账号授权的日期大概有5年）
    // 判断账号是否过期
    NSDate * now = [NSDate date];
    if ([now compare:account.expires_time] == NSOrderedDescending) { // 过期
        return nil;
    }
    return account;
}

+ (void)removeAccount{
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    BOOL isExist = [fileMgr fileExistsAtPath:JXAccountFilePath];
    
    if (isExist) {
        
        NSError *err;
        
        [fileMgr removeItemAtPath:JXAccountFilePath error:&err];
    }
}

+ (void)getTokenWithParams:(JXOAuthGetTokenParams *)params success:(void (^)(JXAccount *))success failure:(void (^)(NSError *))failure {
    [JXHTTPTool POST:kOAuthGetToken params:params.mj_keyValues progress:nil success:^(NSDictionary * responseObj) {
        JXAccount *account = [JXAccount accountWithDict:responseObj];
        if (success) {
            success(account);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
