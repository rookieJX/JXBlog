//
//  JXStatus.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/14.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXStatus.h"
#import "JXPhoto.h"

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

@end
