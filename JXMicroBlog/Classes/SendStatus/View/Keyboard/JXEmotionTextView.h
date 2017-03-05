//
//  JXEmotionTextView.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/5.
//  Copyright © 2017年 王加祥. All rights reserved.
//  带有添加表情

#import "JXTextView.h"

@class HMEmotion;

@interface JXEmotionTextView : JXTextView
// 插入一个表情
- (void)appendEmotion:(HMEmotion *)emotion;
// 获取文字信息
- (NSString *)getTextViewString;
@end
