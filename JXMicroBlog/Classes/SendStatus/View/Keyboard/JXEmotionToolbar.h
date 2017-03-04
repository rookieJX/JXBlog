//
//  JXEmotionToolbar.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/26.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JXEmotionToolbar;

typedef enum {
    JXEmotionTypeRecent, // 最近
    JXEmotionTypeDefault, // 默认
    JXEmotionTypeEmoji, // Emoji
    JXEmotionTypeLxh // 浪小花
} JXEmotionType;

@protocol JXEmotionToolbarDelegate <NSObject>

@optional
- (void)emotionToolbar:(JXEmotionToolbar *)toolbar didSelectedButton:(JXEmotionType)emotionType;

@end

@interface JXEmotionToolbar : UIView
/** 点击代理 */
@property (nonatomic,weak) id<JXEmotionToolbarDelegate> delegate;
@end
