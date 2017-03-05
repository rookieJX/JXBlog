//
//  JXEmotionTextView.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/5.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXEmotionTextView.h"
#import "HMEmotion.h"
#import "JXEmotionAttachment.h"

@implementation JXEmotionTextView
- (void)appendEmotion:(HMEmotion *)emotion {
    if (emotion.emoji) {
        [self insertText:emotion.emoji];
    } else {
        NSAttributedString *attributeString = self.attributedText;
        NSMutableAttributedString *textAttributeString = [[NSMutableAttributedString alloc] initWithAttributedString:attributeString];
        
        // 记录当前光标位置
        NSInteger currentIndex = self.selectedRange.location;
        
        // 图片附件
        JXEmotionAttachment *attachment = [[JXEmotionAttachment alloc] init];
        attachment.emotion = emotion;
        CGFloat imageH = self.font.lineHeight;
        CGFloat imageW = imageH;
        attachment.bounds = CGRectMake(0, -3, imageW, imageH);
        NSAttributedString *imageAttribute = [NSAttributedString attributedStringWithAttachment:attachment];
        
        // 添加图片附件
        [textAttributeString insertAttributedString:imageAttribute atIndex:self.selectedRange.location];
         
        // 这里需要设置控件大小,否则在图片之后的字体大小会变小
        [textAttributeString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, textAttributeString.length)];
        
        self.attributedText = textAttributeString;

        // 重新设置光标位置
        self.selectedRange = NSMakeRange(currentIndex + 1, 0);
    }

}

- (NSString *)getTextViewString {
    NSMutableString *textViewString = [NSMutableString string];
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        JXEmotionAttachment *attach = attrs[@"NSAttachment"];
        if (attach) { // 有图片
            [textViewString appendString:attach.emotion.chs];
        } else { // 没有图片
            NSString *subString = [self.attributedText attributedSubstringFromRange:range].string;
            [textViewString appendString:subString];
            
        }
    }];
    
    return textViewString;
}

//- (void)appendEmotion:(HMEmotion *)emotion {
//    // 取出之前的内容
//    NSAttributedString *attributeString = self.attributedText;
//    NSMutableAttributedString *textAttributeString = [[NSMutableAttributedString alloc] initWithAttributedString:attributeString];
//
//    // 选中表情
//    if (emotion.emoji) {
//        NSAttributedString *subEmojiString = [[NSAttributedString alloc] initWithString:emotion.emoji];
//        [textAttributeString appendAttributedString:subEmojiString];
//    } else {
//        // 带图片的附件
//        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
//        NSString *imageName = [NSString stringWithFormat:@"%@/%@",emotion.floder,emotion.png];
//        attachment.image = [UIImage imageNamed:imageName];
//        CGFloat imageH = self.font.lineHeight;
//        CGFloat imageW = imageH;
//        attachment.bounds = CGRectMake(0, -3, imageW, imageH);
//        NSAttributedString *imageAttribute = [NSAttributedString attributedStringWithAttachment:attachment];
//        [textAttributeString appendAttributedString:imageAttribute];
//    }
//    
//    // 这里需要设置控件大小,否则在图片之后的字体大小会变小
//    [textAttributeString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, textAttributeString.length)];
//    
//    self.attributedText = textAttributeString;
//}
@end
