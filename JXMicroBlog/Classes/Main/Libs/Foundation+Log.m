//
//  NSDictionary+Log.m
//  05-掌握-多值参数
//
//  Created by xiaomage on 15/7/13.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@implementation UIView (Log)

+ (NSString *)searchAllSubviews:(UIView *)superView {
    
    // 这样打印的xml没有跟,所以不是标准的xml格式
    NSMutableString *xml = [NSMutableString string];
    NSString *class = NSStringFromClass(superView.class);
    class = [class stringByReplacingOccurrencesOfString:@"_" withString:@""];
    [xml appendFormat:@"<%@ frame=\"%@\">",class,NSStringFromCGRect(superView.frame)];
    for (UIView *childView in superView.subviews) {
        [self searchAllSubviews:childView];
    }
    [xml appendFormat:@"</%@>",class];
    return xml;
}

- (NSString *)description {
    return [UIView searchAllSubviews:self];
}

@end


@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个{
    [string appendString:@"{\n"];
    
    // 遍历所有的键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [string appendFormat:@"\t%@", key];
        [string appendString:@" : "];
        [string appendFormat:@"%@,\n", obj];
    }];
    
    // 结尾有个}
    [string appendString:@"}"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
    [string deleteCharactersInRange:range];
    
    return string;
}
@end

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个[
    [string appendString:@"[\n"];
    
    // 遍历所有的元素
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [string appendFormat:@"\t%@,\n", obj];
    }];
    
    // 结尾有个]
    [string appendString:@"]"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
    [string deleteCharactersInRange:range];
    
    return string;
}

@end
