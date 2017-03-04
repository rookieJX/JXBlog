//
//  JXComposeTool.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/19.
//  Copyright © 2017年 王加祥. All rights reserved.
//  发微博

#import <Foundation/Foundation.h>
#import "JXSendStatusWithOutPhotoParams.h" // 发表没有图片微博参数


@interface JXComposeTool : NSObject

+ (void)composeWithOutPhotoStatusWithParams:(JXSendStatusWithOutPhotoParams *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

+ (void)composeWithPhotoStatusWithParams:(JXSendStatusWithOutPhotoParams *)params imageData:(NSData *)data success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;
@end
