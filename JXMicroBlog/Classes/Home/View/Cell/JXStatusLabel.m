//
//  JXStatusLabel.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/7.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXStatusLabel.h"
#import "JXLinkModel.h"


#define kLinkBackGroundTag 10000

@interface JXStatusLabel ()
/** UITextView */
@property (nonatomic,weak) UITextView * textView;
/** 存放所有链接 */
@property (nonatomic,strong) NSMutableArray * links;
@end

@implementation JXStatusLabel

- (NSMutableArray *)links{
    if (_links == nil) {
        
        NSMutableArray *links = [NSMutableArray array];
        
        // 计算所有出现的连接
        [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
            NSString *linkText = attrs[kHomeStatusLinks];
            if (linkText == nil) return ;
            
            JXLinkModel *link = [[JXLinkModel alloc] init];
            link.text = linkText;
            link.range = range;
            
            NSMutableArray *rects = [NSMutableArray array];
            // 框住所有东西
            self.textView.selectedRange = range;
            NSArray * selectionRects = [self.textView selectionRectsForRange:self.textView.selectedTextRange];
            for (UITextSelectionRect *selectRect in selectionRects) {
                
                if (selectRect.rect.size.width == 0 ||selectRect.rect.size.height == 0) continue;
                [rects addObject:selectRect];
                
                
            }
            
            link.rects = rects;
            [links addObject:link];
        }];

    
        _links = links;
    }
    return _links;
}

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
    self.links = nil;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    // 拿到被点击的连接
    JXLinkModel *touchingLink = [self touchingLinkWithPoint:point];
    
    [self showBackGroundWithLink:touchingLink];
    
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    JXLog(@"%@",NSStringFromCGPoint(point));
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    // 拿到被点击的连接
    JXLinkModel *touchingLink = [self touchingLinkWithPoint:point];
    if (touchingLink) {
        // 连接有值,说明手指抬起的时候仍然在连接上
        [[NSNotificationCenter defaultCenter] postNotificationName:kJXLinkDidSelectedNotification object:nil userInfo:@{kHomeStatusLinks:touchingLink.text}];
    }
   
    // 相当于取消
    [self touchesCancelled:touches withEvent:event];
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeAllLinkBackGround];
    });
}

#pragma mark - 处理触摸
// 根据触摸点返回被触摸的连接
- (JXLinkModel *)touchingLinkWithPoint:(CGPoint)point {
    __block JXLinkModel *touchingLink = nil;
    [self.links enumerateObjectsUsingBlock:^(JXLinkModel *link, NSUInteger idx, BOOL * _Nonnull stop) {
        for (UITextSelectionRect *selectRect in link.rects) {
            if (CGRectContainsPoint(selectRect.rect, point)) {
                touchingLink = link;
                break;
            }
        }
    }];
    return touchingLink;
}

// 根据连接来显示背景色
- (void)showBackGroundWithLink:(JXLinkModel *)link {
    for (UITextSelectionRect *selectRect in link.rects) {
        UIView *view = [[UIView alloc] init];
        view.tag = kLinkBackGroundTag;
        view.frame = selectRect.rect;
        view.backgroundColor = [UIColor redColor];
        [self insertSubview:view atIndex:0];
    }
}

- (void)removeAllLinkBackGround {
    for (UIView *childView in self.subviews) {
        if (childView.tag == kLinkBackGroundTag) {
            [childView removeFromSuperview];
        }
    }
}


// 如果事件为连接那么自己处理,否则不处理
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if ([self touchingLinkWithPoint:point]) {
        return self;
    }
    return nil;
}
@end
