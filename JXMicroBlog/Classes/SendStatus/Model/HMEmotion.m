//
//  HMEmotion.m
//  黑马微博
//
//  Created by apple on 14-7-15.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMEmotion.h"
#import "NSString+Emoji.h"


@implementation HMEmotion
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@ - %@", self.chs, self.png, self.code];
}

- (void)setCode:(NSString *)code {
    _code = code;
    if (code == nil) return;
    self.emoji = [NSString emojiWithStringCode:code];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.chs = [coder decodeObjectForKey:@"chs"];
        self.cht = [coder decodeObjectForKey:@"cht"];
        self.png = [coder decodeObjectForKey:@"png"];
        self.code = [coder decodeObjectForKey:@"code"];
        self.floder = [coder decodeObjectForKey:@"floder"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.chs forKey:@"chs"];
    [aCoder encodeObject:self.cht forKey:@"cht"];
    [aCoder encodeObject:self.png forKey:@"png"];
    [aCoder encodeObject:self.code forKey:@"code"];
    [aCoder encodeObject:self.floder forKey:@"floder"];
}

- (BOOL)isEqual:(HMEmotion *)otherEmotion {
    if (self.code) {
        return [self.code isEqualToString:otherEmotion.code];
    } else {
        return [self.png isEqualToString:otherEmotion.png] && [self.floder isEqualToString:otherEmotion.floder] && [self.cht isEqualToString:otherEmotion.cht];
    }
}
@end
