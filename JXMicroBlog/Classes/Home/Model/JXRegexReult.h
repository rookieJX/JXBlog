//
//  JXRegexReult.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/5.
//  Copyright © 2017年 王加祥. All rights reserved.
//  获取匹配到的结果

#import <Foundation/Foundation.h>

@interface JXRegexReult : NSObject
/** 匹配到字段 */
@property (nonatomic,copy) NSString * string;
/** 匹配到位置 */
@property (nonatomic,assign) NSRange range;
/** 匹配到是否为图片 */
@property (nonatomic,assign,getter=isEmotion) BOOL emotion;
@end
