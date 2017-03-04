//
//  JXEmotionKeyboard.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/26.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXEmotionKeyboard.h"
#import "JXEmotionListView.h"
#import "JXEmotionToolbar.h"
#import "HMEmotion.h"
#import "JXEmotionTool.h"

@interface JXEmotionKeyboard ()<JXEmotionToolbarDelegate>
/** 表情 */
@property (nonatomic,weak) JXEmotionListView * listView;
/** 底部按钮 */
@property (nonatomic,weak) JXEmotionToolbar * toolbar;


@end

@implementation JXEmotionKeyboard


+ (instancetype)emotionKeyboard {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        JXEmotionListView *listView = [[JXEmotionListView alloc] init];
        [self addSubview:listView];
        listView.backgroundColor = [UIColor whiteColor];
        self.listView = listView;
        
        JXEmotionToolbar *toolbar = [[JXEmotionToolbar alloc] init];
        toolbar.delegate = self;
        [self addSubview:toolbar];
        self.toolbar = toolbar;
        
        
    }
    return self;
}

#pragma mark - JXEmotionToolbarDelegate
- (void)emotionToolbar:(JXEmotionToolbar *)toolbar didSelectedButton:(JXEmotionType)emotionType {
    switch (emotionType) {
        case JXEmotionTypeDefault:// 默认
            self.listView.emotions = [JXEmotionTool defaultEmotions];
            break;
            
        case JXEmotionTypeEmoji: // Emoji
            self.listView.emotions = [JXEmotionTool emojiEmotions];
            break;
            
        case JXEmotionTypeLxh: // 浪小花
            self.listView.emotions = [JXEmotionTool lxhEmotions];
            break;
        case JXEmotionTypeRecent: // 最近
            self.listView.emotions = [JXEmotionTool recentEmotions];
            break;
        default:
            break;
    }
}

#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 底部按钮
    self.toolbar.w = self.w;
    self.toolbar.h = 35;
    self.toolbar.x = 0;
    self.toolbar.y = self.h - self.toolbar.h;
    
    // 表情
    self.listView.x = 0;
    self.listView.y = 0;
    self.listView.w = self.w;
    self.listView.h = self.toolbar.y;
    
}
@end
