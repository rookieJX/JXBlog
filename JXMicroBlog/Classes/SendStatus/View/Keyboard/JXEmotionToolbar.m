//
//  JXEmotionToolbar.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/26.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXEmotionToolbar.h"


#define  JXEmotionToolbarButtonMaxCount 4

@interface JXEmotionToolbar ()
/** 记录当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;

@end
@implementation JXEmotionToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 3.添加4个工具条按钮
        [self setupToolbarButton:@"最近" type:JXEmotionTypeRecent];
        [self setupToolbarButton:@"默认" type:JXEmotionTypeDefault];
        [self setupToolbarButton:@"Emoji" type:JXEmotionTypeEmoji];
        [self setupToolbarButton:@"浪小花" type:JXEmotionTypeLxh];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(emotionKeyboardClick:)
                                                     name:kJXEmotionDidSelectedNotification
                                                   object:nil];
    }
    return self;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)emotionKeyboardClick:(NSNotification *)notification {
    JXEmotionType type = (JXEmotionType)self.selectedButton.tag;
    if (type == JXEmotionTypeRecent) {
        [self toolbarButtonClick:self.selectedButton];
    }
}
- (UIButton *)setupToolbarButton:(NSString *)title type:(JXEmotionType)type
{
    UIButton *button = [[UIButton alloc] init];
    
    // 文字
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(toolbarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    
    button.tag = type;
    
    // 添加按钮
    [self addSubview:button];
    
    // 设置背景图片
    NSInteger count = self.subviews.count;
    if (count == 1) { // 第一个按钮
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_left_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_left_selected"] forState:UIControlStateSelected];
    } else if (count == JXEmotionToolbarButtonMaxCount) { // 最后一个按钮
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_right_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_right_selected"] forState:UIControlStateSelected];
    } else { // 中间按钮
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_mid_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_mid_selected"] forState:UIControlStateSelected];
    }
    
    return button;
}

- (void)toolbarButtonClick:(UIButton *)button
{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    JXEmotionType type = (JXEmotionType)button.tag;
    if (self.delegate && [self.delegate respondsToSelector:@selector(emotionToolbar:didSelectedButton:)]) {
        [self.delegate emotionToolbar:self didSelectedButton:type];
    }
}

- (void)setDelegate:(id<JXEmotionToolbarDelegate>)delegate {
    _delegate = delegate;
    
    // 获得“默认”按钮
    UIButton *defaultButton = (UIButton *)[self viewWithTag:JXEmotionTypeDefault];
    // 默认选中“默认”按钮
    [self toolbarButtonClick:defaultButton];
}

#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    // 3.设置工具条按钮的frame
    CGFloat buttonW = self.w / JXEmotionToolbarButtonMaxCount;
    CGFloat buttonH = self.h;
    for (int i = 0; i<JXEmotionToolbarButtonMaxCount; i++) {
        UIButton *button = self.subviews[i];
        button.w = buttonW;
        button.h = buttonH;
        button.x = i * buttonW;
    }
}

@end
