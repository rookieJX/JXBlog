//
//  JXHomeUnreadeCountParam.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/19.
//  Copyright © 2017年 王加祥. All rights reserved.
//  未读个数参数模型

#import <Foundation/Foundation.h>

@interface JXHomeUnreadeCountParam : NSObject

/** 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。 */
@property (nonatomic,copy) NSString * access_token;
/** 需要获取消息未读数的用户UID，必须是当前登录用户。 */
@property (nonatomic,copy) NSString * uid;

+ (instancetype)params;
@end
