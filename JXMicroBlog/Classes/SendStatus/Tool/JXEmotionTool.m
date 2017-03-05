//
//  JXEmotionTool.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/4.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXEmotionTool.h"
#import "HMEmotion.h"

#define JXRecentEmotionFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recent_emotions.archive"]


@implementation JXEmotionTool


/** 默认表情 */
static NSArray *_defaultEmotions;
/** emoji表情 */
static NSArray *_emojiEmotions;
/** 浪小花表情 */
static NSArray *_lxhEmotions;

/** 最近表情 */
static NSMutableArray *_recentEmotions;


+ (NSArray *)defaultEmotions
{
    if (!_defaultEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        
        _defaultEmotions = [HMEmotion mj_objectArrayWithFile:plist];
        [_defaultEmotions makeObjectsPerformSelector:@selector(setFloder:) withObject:@"EmotionIcons/default"];
    }
    return _defaultEmotions;
}

+ (NSArray *)emojiEmotions
{
    if (!_emojiEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        _emojiEmotions = [HMEmotion mj_objectArrayWithFile:plist];
        [_emojiEmotions makeObjectsPerformSelector:@selector(setFloder:) withObject:@"EmotionIcons/emoji"];
    }
    return _emojiEmotions;
}

+ (NSArray *)lxhEmotions
{
    if (!_lxhEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        _lxhEmotions = [HMEmotion mj_objectArrayWithFile:plist];
        [_lxhEmotions makeObjectsPerformSelector:@selector(setFloder:) withObject:@"EmotionIcons/lxh"];
    }
    return _lxhEmotions;
}

+ (NSArray *)recentEmotions {
    if (!_recentEmotions) {
        _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:JXRecentEmotionFilePath];
        if (!_recentEmotions) {
            _recentEmotions = [NSMutableArray array];
        }
    }
    return _recentEmotions;
}

+ (void)addRecentEmotion:(HMEmotion *)emotion {
    
    [self recentEmotions];
    
    [_recentEmotions removeObject:emotion];
    
    [_recentEmotions insertObject:emotion atIndex:0];
    // 存储
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:JXRecentEmotionFilePath];;
}

+ (HMEmotion *)emotionWithDesc:(NSString *)desc {
    if (!desc) return nil;
    __block HMEmotion *foundEmotion = nil;
    [[self defaultEmotions] enumerateObjectsUsingBlock:^(HMEmotion *emotion, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([desc isEqualToString:foundEmotion.chs] || [desc isEqualToString:foundEmotion.cht]) {
            foundEmotion = emotion;
            *stop = YES;
        }
    }];
    
    if (foundEmotion) return foundEmotion;
    
    [[self lxhEmotions] enumerateObjectsUsingBlock:^(HMEmotion *emotion, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([desc isEqualToString:foundEmotion.chs] || [desc isEqualToString:foundEmotion.cht]) {
            foundEmotion = emotion;
            *stop = YES;
        }
    }];
    
    return foundEmotion;
}

@end
