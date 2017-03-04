//
//  JXEmotionGridView.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/1.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXEmotionGridView.h"
#import "HMEmotion.h"
#import "JXEmotionView.h" // 单个表情视图
#import "JXEmotionPopView.h"
#import "JXEmotionTool.h"

#define kEmotionGridInsetLeft 15
#define kEmotionGridInsetTop 15

@interface JXEmotionGridView ()
/** 保存表情按钮 */
@property (nonatomic,strong) NSMutableArray * emotionsArray;
/** 删除按钮 */
@property (nonatomic,weak) UIButton * deleteButton;
/** 弹出视图 */
@property (nonatomic,strong) JXEmotionPopView *popView;
@end

@implementation JXEmotionGridView
- (JXEmotionPopView *)popView{
    if (_popView == nil) {
        _popView = [[JXEmotionPopView alloc] init];
    }
    return _popView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
        
        UILongPressGestureRecognizer *pressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:pressGesture];
    }
    return self;
}

- (JXEmotionView *)emotionViewWithPoint:(CGPoint)point {
    __block JXEmotionView *foundEmotionView = nil;
    
    [self.emotionsArray enumerateObjectsUsingBlock:^(JXEmotionView * emotionView, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectContainsPoint(emotionView.frame, point)) {
            foundEmotionView = emotionView;
            // 如果找到就停止
            *stop = YES;
        }
    }];
    return foundEmotionView;
}

// 长按手势
- (void)longPress:(UIGestureRecognizer *)recognizer {
    
    CGPoint currentPoint = [recognizer locationInView:recognizer.view];
    JXEmotionView *emotionView = [self emotionViewWithPoint:currentPoint];
    
    
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self.popView removeFromSuperview];
        [self postEmotionWithEmotion:emotionView.emotion];
    } else {
    
        [self.popView showEmotionFromEmotionView:emotionView];
    }
}

- (NSMutableArray *)emotionsArray{
    if (_emotionsArray == nil) {
        _emotionsArray = [NSMutableArray array];
    }
    return _emotionsArray;
}

- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    
    NSInteger count = emotions.count;
    NSInteger currentEmotionCount = self.emotionsArray.count;
    for (NSInteger i=0; i<count; i++) {
        JXEmotionView *emotionButton = nil;
        
        if (i >= currentEmotionCount) {
            emotionButton = [[JXEmotionView alloc] init];
            [emotionButton addTarget:self action:@selector(emotionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:emotionButton];
            [self.emotionsArray addObject:emotionButton];
        } else {
            emotionButton = self.emotionsArray[i];
        }
        
        
        HMEmotion *emotion = emotions[i];
        emotionButton.emotion = emotion;       
        emotionButton.hidden = NO;
    }
    
    for (NSInteger i=count; i<currentEmotionCount; i++) {
        UIButton *emotionButton = self.emotionsArray[i];
        emotionButton.hidden = YES;
    }
    
}

- (void)emotionButtonClick:(JXEmotionView *)emotionView {
    [self.popView showEmotionFromEmotionView:emotionView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    // 选中表情
    [self postEmotionWithEmotion:emotionView.emotion];
}

// 发送表情
- (void)postEmotionWithEmotion:(HMEmotion *)emotion {
    
    if (emotion == nil) return;
    
    [JXEmotionTool addRecentEmotion:emotion];
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kJXEmotionDidSelectedNotification
                                                        object:nil
                                                      userInfo:@{kJXDidSelectedEmotion:emotion}];
}

// 点击删除
- (void)deleteButtonClick {
    [[NSNotificationCenter defaultCenter] postNotificationName:kJXEmotionDidDeleteNotification
                                                        object:nil
                                                      userInfo:nil];
}
#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger count = self.emotionsArray.count;
    CGFloat w = (self.w - 2 * kEmotionGridInsetLeft) / JXEmotionMaxCols;
    CGFloat h = (self.h - kEmotionGridInsetTop) / JXEmotionMaxRows;
    for (NSInteger i=0; i<count; i++) {
        UIButton *button = self.emotionsArray[i];
        button.x = kEmotionGridInsetLeft + (i % JXEmotionMaxCols) * w;
        button.y = kEmotionGridInsetTop + (i / JXEmotionMaxCols) * h;
        button.w = w;
        button.h = h;
    }
    
    // 设置按钮尺寸
    self.deleteButton.w = w;
    self.deleteButton.h = h;
    self.deleteButton.x = self.w - kEmotionGridInsetLeft - w;
    self.deleteButton.y = self.h - h;
    
}
@end
