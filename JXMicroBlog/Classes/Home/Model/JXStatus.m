//
//  JXStatus.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/14.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXStatus.h"
#import "JXPhoto.h"
#import "RegexKitLite.h"
#import "JXRegexReult.h"
#import "JXEmotionAttachment.h"
#import "JXEmotionTool.h"
#import "JXUserModel.h"

@implementation JXStatus

+ (NSDictionary *)mj_objectClassInArray {
    return @{
                @"pic_urls":[JXPhoto class]
             };
}

- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    // 真机调试
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    // 获得微博发布的具体时间
    NSDate *createDate = [fmt dateFromString:_created_at];
    
    // 判断是否为今年
    if (createDate.isThisYear) {
        if (createDate.isToday) { // 今天
            NSDateComponents *cmps = [createDate deltaWithNow];
            if (cmps.hour >= 1) { // 至少是1小时前发的
                return [NSString stringWithFormat:@"%ld小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1~59分钟之前发的
                return [NSString stringWithFormat:@"%ld分钟前", cmps.minute];
            } else { // 1分钟内发的
                return @"刚刚";
            }
        } else if (createDate.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else { // 至少是前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:createDate];
    }
}


- (void)setSource:(NSString *)source
{
    // 截取范围
//    NSRange range;
//    range.location = [source rangeOfString:@">"].location + 1;
//    range.length = [source rangeOfString:@"</"].location - range.location;
//    // 开始截取
//    NSString *subsource = [source substringWithRange:range];
    
//    _source = [NSString stringWithFormat:@"来自%@", subsource];
    _source = [NSString stringWithFormat:@"来自%@", @"智障"];
}


// 根据匹配规则以及需要匹配的文字来进行排序,返回的结果为排序完成的数组
- (NSArray *)regexResultWithText:(NSString *)text regex:(NSString *)regex{
    // 存放匹配到字符
    NSMutableArray *results = [NSMutableArray array];
    // 获取匹配到的字符
    [text enumerateStringsMatchedByRegex:regex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        JXRegexReult *result = [[JXRegexReult alloc] init];
        result.range = *capturedRanges;
        result.string = *capturedStrings;
        result.emotion = YES;
        [results addObject:result];
    }];
    // 获取除匹配到之外的字符
    [text enumerateStringsSeparatedByRegex:regex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        JXRegexReult *result = [[JXRegexReult alloc] init];
        result.range = *capturedRanges;
        result.string = *capturedStrings;
        result.emotion = NO;
        [results addObject:result];
    }];
    // 排序
    [results sortUsingComparator:^NSComparisonResult(JXRegexReult *result1, JXRegexReult *result2) {
        NSInteger loc1 = result1.range.location;
        NSInteger loc2 = result2.range.location;
        return [@(loc1) compare:@(loc2)];
        
        //        if (loc1 < loc2) { // 升序(右边大)
        //            return NSOrderedAscending;
        //        } else if (loc1 > loc2) {
        //            return NSOrderedDescending;
        //        } else {
        //            return NSOrderedSame;
        //        }
    }];
    
    return results;

}

- (void)setRetweeted_status:(JXStatus *)retweeted_status {
    _retweeted_status = retweeted_status;
    self.retweeted = NO; // 当前自己发表的微博设置为NO
    retweeted_status.retweeted = YES; // 说明是转发的微博
}

- (void)setRetweeted:(BOOL)retweeted { // 如果没有转发微博这个方法不会调用
    _retweeted = retweeted;
    if (retweeted) {
        NSString *text = [NSString stringWithFormat:@"@%@:%@",self.user.name,self.text];
        
        NSAttributedString *attributeText = [self attributeStringWithText:text];
        
        self.attributeText = attributeText;
    } else {
        NSString *text = [NSString stringWithFormat:@"%@",self.text];
        
        NSAttributedString *attributeText = [self attributeStringWithText:text];
        
        self.attributeText = attributeText;
    }
}

- (void)setText:(NSString *)text {
    _text = [text copy];
    
    [self createAttributeString];
    
}

- (void)setUser:(JXUserModel *)user {
    _user = user;
    
     [self createAttributeString];
}

- (void)createAttributeString {
    
    if (self.user == nil || self.text == nil || self.attributeText != nil) return;
    
    NSString *text = [NSString stringWithFormat:@"%@",self.text];
    NSAttributedString *attributeText = [self attributeStringWithText:text];
    
    self.attributeText = attributeText;
}

- (NSAttributedString *)attributeStringWithText:(NSString *)text {
    // 正则匹配规则
    NSString *regex = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    
    NSArray *results = [self regexResultWithText:text regex:regex];
    
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc] init];
    
    // 遍历数组开始拼接
    [results enumerateObjectsUsingBlock:^(JXRegexReult *result, NSUInteger idx, BOOL * _Nonnull stop) {
        HMEmotion *emotion = nil;
        if (result.isEmotion) { // 是表情
            // 图片
            emotion = [JXEmotionTool emotionWithDesc:result.string];
        }
        
        if (emotion) { // 如果有表情
            
            JXEmotionAttachment *attachment = [[JXEmotionAttachment alloc] init];
            attachment.emotion = emotion;
            attachment.bounds = CGRectMake(0, -3, kHomeOriginalContentFont.lineHeight, kHomeOriginalContentFont.lineHeight);
            NSAttributedString *imageAttribute = [NSAttributedString attributedStringWithAttachment:attachment];
            [attributeText appendAttributedString:imageAttribute];
        } else { // 普通文本
            NSMutableAttributedString *subAttribute = [[NSMutableAttributedString alloc] initWithString:result.string];
            // 匹配 ##
            NSString *trendRegex = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
            [result.string enumerateStringsMatchedByRegex:trendRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [subAttribute addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:*capturedRanges];
                [subAttribute addAttribute:kHomeStatusLinks value:*capturedStrings range:*capturedRanges];
            }];
            
            // 匹配 @
            NSString *mentionRegex = @"@[0-9a-zA-Z\\u4e00-\\u9fa5\\-_]+ ?";
            [result.string enumerateStringsMatchedByRegex:mentionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [subAttribute addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:*capturedRanges];
                [subAttribute addAttribute:kHomeStatusLinks value:*capturedStrings range:*capturedRanges];
            }];
            
            // 匹配超链接
            // 匹配超链接
            NSString *httpRegex = @"http(s)?://([a-zA-Z|\\d]+\\.)+[a-zA-Z|\\d]+(/[a-zA-Z|\\d|\\-|\\+|_./?%&=]*)?";
            [result.string enumerateStringsMatchedByRegex:httpRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [subAttribute addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:*capturedRanges];
                [subAttribute addAttribute:kHomeStatusLinks value:*capturedStrings range:*capturedRanges]; 
            }];
            
            
            [attributeText appendAttributedString:subAttribute];
        }
    }];
    
    [attributeText addAttribute:NSFontAttributeName value:kHomeOriginalContentFont range:NSMakeRange(0, attributeText.length)];
    
    return attributeText;
}
@end
