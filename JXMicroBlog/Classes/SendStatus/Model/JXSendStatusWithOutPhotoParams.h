//
//  JXSendStatusWithOutPhotoParams.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/18.
//  Copyright © 2017年 王加祥. All rights reserved.
//  发表没有图片的微博参数

#import <Foundation/Foundation.h>

@interface JXSendStatusWithOutPhotoParams : NSObject
/** 采用OAuth授权方式为必填参数，OAuth授权后获得。 */
@property (nonatomic,copy) NSString * access_token;
/** 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。 */
@property (nonatomic,copy) NSString * status;

@end
