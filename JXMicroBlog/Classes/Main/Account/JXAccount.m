//
//  JXAccount.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/13.
//  Copyright © 2017年 王加祥. All rights reserved.
//  账号信息

#import "JXAccount.h"
@implementation JXAccount
+ (instancetype)accountWithDict:(NSDictionary *)dict {
    JXAccount * account = [[self alloc] init];
    
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.uid = dict[@"uid"];
    
    // 确定账号过期时间：账号创建的时间加上有效期
    NSDate * now = [NSDate date];
    account.expires_time = [now dateByAddingTimeInterval:account.expires_in.doubleValue];
    
    return account;
}


/**
 *  当从文件中读取一个对象的时候调用
 *  在这个方法中写清楚怎么解析文件中的数据，利用key来解析数据
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.expires_time = [aDecoder decodeObjectForKey:@"expires_time"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}

/**
 *  当将一个对象存储到文件中的时候需要调用
 *  这这个方法中写清楚要存储哪些属性，以及定义怎么存储属性，以及存储哪些属性
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.expires_time forKey:@"expires_time"];
    [aCoder encodeObject:self.name forKey:@"name"];
}
@end
