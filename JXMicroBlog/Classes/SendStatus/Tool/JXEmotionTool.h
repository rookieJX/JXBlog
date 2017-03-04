//
//  JXEmotionTool.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/4.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HMEmotion;

@interface JXEmotionTool : NSObject
/** 默认表情 */
+ (NSArray *)defaultEmotions;
/** emoji表情 */
+ (NSArray *)emojiEmotions;
/** 浪小花表情 */
+ (NSArray *)lxhEmotions;
/** 最近表情 */
+ (NSArray *)recentEmotions;

// 添加最近表情
+ (void)addRecentEmotion:(HMEmotion *)emotion;
@end
