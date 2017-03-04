//
//  JXTextView.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/16.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXTextView.h"

@interface JXTextView ()
/** 占位Label */
@property (nonatomic,weak) UILabel * placeHolderLabel;

@end

@implementation JXTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *placeHolderLabel = [[UILabel alloc] init];
        placeHolderLabel.textColor = [UIColor lightGrayColor];
        placeHolderLabel.numberOfLines = 0;
        [self addSubview:placeHolderLabel];
        self.placeHolderLabel = placeHolderLabel;
        
        self.font = [UIFont systemFontOfSize:15.0f];
        
        // object:监听自己发出的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

// 占位文字
- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = [placeHolder copy];
    
    self.placeHolderLabel.text = placeHolder;
    
    [self setNeedsLayout];
}

// 文字大小尺寸
- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.placeHolderLabel.font = font;
    [self setNeedsLayout];
}

// 复制粘贴来的文字
- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChange];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)textChange {
    self.placeHolderLabel.hidden = self.text.length != 0;
}
#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.placeHolderLabel.x = 5;
    self.placeHolderLabel.y = 8;
    self.placeHolderLabel.w = self.w - 2 * self.placeHolderLabel.x;
    CGSize size = CGSizeMake(self.placeHolderLabel.w, MAXFLOAT);
    NSDictionary *dict = @{NSFontAttributeName:self.font};
    self.placeHolderLabel.h = [self.placeHolder boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
}
@end
