//
//  JXOAuthGetTokenParams.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/12.
//  Copyright © 2017年 王加祥. All rights reserved.
//  获取token参数

#import <Foundation/Foundation.h>

@interface JXOAuthGetTokenParams : NSObject
/** 申请应用时分配的AppKey */
@property (nonatomic,copy) NSString * client_id;
/** 申请应用时分配的AppSecret */
@property (nonatomic,copy) NSString * client_secret;
/** 请求的类型，填写authorization_code */
@property (nonatomic,copy) NSString * grant_type;
/** 调用authorize获得的code值 */
@property (nonatomic,copy) NSString * code;
/** 回调地址，需需与注册应用里的回调地址一致 */
@property (nonatomic,copy) NSString * redirect_uri;
@end
