//
//  JXGlobalItem.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/9.
//  Copyright © 2017年 王加祥. All rights reserved.
//  标题,子标题,表格样式等

#import <Foundation/Foundation.h>

@interface JXGlobalItem : NSObject
/** 标题 */
@property (nonatomic,copy) NSString * title;
/** 子标题 */
@property (nonatomic,copy) NSString * subTitle;
/** 图片 */
@property (nonatomic,copy) NSString * icon;
/** 数字 */
@property (nonatomic,copy) NSString * bageVaule;
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;
+ (instancetype)itemWithTitle:(NSString *)title;
@end
