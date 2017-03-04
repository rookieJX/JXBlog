//
//  JXComposeToolBar.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/18.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXComposeToolBar.h"

@interface JXComposeToolBar ()
/** 表情按钮 */
@property (nonatomic,weak) UIButton * emotionButton;
@end

@implementation JXComposeToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage originalImageWithImageName:@"compose_toolbar_background"]];
        
        [self addButtonWithNomalImage:@"compose_camerabutton_background"
                   highlightImageName:@"compose_camerabutton_background_highlighted"
                          composeType:ComposeTypeCamera];
        
        [self addButtonWithNomalImage:@"compose_toolbar_picture"
                   highlightImageName:@"compose_toolbar_picture_highlighted"
                          composeType:ComposeTypePhoto];
        
        [self addButtonWithNomalImage:@"compose_mentionbutton_background"
                   highlightImageName:@"compose_mentionbutton_background_highlighted"
                          composeType:ComposeTypeMention];
        
        [self addButtonWithNomalImage:@"compose_trendbutton_background"
                   highlightImageName:@"compose_trendbutton_background_highlighted"
                          composeType:ComposeTypeImport];
        
        self.emotionButton = [self addButtonWithNomalImage:@"compose_emoticonbutton_background"
                   highlightImageName:@"compose_emoticonbutton_background_highlighted"
                          composeType:ComposeTypeEmotion];
    }
    return self;
}

- (UIButton *)addButtonWithNomalImage:(NSString *)nomalImageName highlightImageName:(NSString *)lightImageName composeType:(ComposeType)type {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = type;
    [button setImage:[UIImage imageNamed:nomalImageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:lightImageName] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    return button;
}

- (void)buttonClick:(UIButton *)sender {
    ComposeType type = (ComposeType)sender.tag;
    if ([self.delegate respondsToSelector:@selector(composeToolBarDidSelectButtonType:)]) {
        [self.delegate composeToolBarDidSelectButtonType:type];
    }
}

- (void)setShowEmotion:(BOOL)showEmotion {
    _showEmotion = showEmotion;
    if (showEmotion) { // 如果是表情
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    } else { // 如果是系统键盘
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
}
#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    CGFloat width = self.w / count;
    CGFloat hight = self.h;
    
    for (NSInteger i = 0; i<count; i++) {
        UIButton *button = self.subviews[i];
        button.w = width;
        button.h = hight;
        button.x = i * width;
        button.y = 0;
    }
}
@end
