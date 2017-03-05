//
//  JXEmotionAttachment.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/5.
//  Copyright © 2017年 王加祥. All rights reserved.
//  带表情的附件

#import <UIKit/UIKit.h>

@class HMEmotion;

@interface JXEmotionAttachment : NSTextAttachment
/** 表情模型 */
@property (nonatomic,strong) HMEmotion * emotion;
@end
