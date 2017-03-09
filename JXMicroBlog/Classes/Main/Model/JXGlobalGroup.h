//
//  JXGlobalGroup.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/9.
//  Copyright © 2017年 王加祥. All rights reserved.
//  用来描述每组信息

#import <Foundation/Foundation.h>

@interface JXGlobalGroup : NSObject
/** 组头 */
@property (nonatomic,copy) NSString * header;
/** 组尾 */
@property (nonatomic,copy) NSString * footer;
/** 这组所有信息(存放为模型) */
@property (nonatomic,strong) NSArray * items;

+ (instancetype)group;

@end
