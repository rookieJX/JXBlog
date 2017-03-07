//
//  JXStatusLabel.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/7.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXStatusLabel.h"

@interface JXStatusLabel ()
/** UITextView */
@property (nonatomic,weak) UITextView * textView;
@end

@implementation JXStatusLabel
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITextView *textView = [[UITextView alloc] init];
        textView.scrollEnabled = NO;
        // 设置文字内边距
        textView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        textView.backgroundColor = [UIColor clearColor];
        // 不能点击
        textView.editable = NO;
        textView.userInteractionEnabled = NO;
        [self addSubview:textView];
        self.textView = textView;
    }
    return self;
}

#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textView.frame = self.bounds;
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    _attributedText = attributedText;
    self.textView.attributedText = attributedText;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    
    // 计算所有出现的连接
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        NSString *linkText = attrs[kHomeStatusLinks];
        if (linkText == nil) return ;
        
        // 框住所有东西
        self.textView.selectedRange = range;
        NSArray *rects = [self.textView selectionRectsForRange:self.textView.selectedTextRange];
        for (UITextSelectionRect *selectRect in rects) {
            
            if (CGRectContainsPoint(selectRect.rect, point)) {
                
                UIView *view = [[UIView alloc] init];
                view.frame = selectRect.rect;
                view.backgroundColor = [UIColor redColor];
                [self insertSubview:view atIndex:0];
            }
            
        }
    }];
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    JXLog(@"%@",NSStringFromCGPoint(point));
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    JXLog(@"%@",NSStringFromCGPoint(point));
}
@end
