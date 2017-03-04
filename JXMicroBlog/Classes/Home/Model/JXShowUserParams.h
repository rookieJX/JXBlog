//
//  JXShowUserParams.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/18.
//  Copyright © 2017年 王加祥. All rights reserved.
//  获取用户昵称

#import <Foundation/Foundation.h>

@interface JXShowUserParams : NSObject
/** 采用OAuth授权方式为必填参数，OAuth授权后获得。 */
@property (nonatomic,copy) NSString * access_token;
/** 需要查询的用户ID。 */
@property (nonatomic,copy) NSString * uid;
@end
