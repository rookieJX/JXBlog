//
//  JXPhoto.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/14.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXPhoto.h"

@implementation JXPhoto
- (void)setThumbnail_pic:(NSString *)thumbnail_pic {
    _thumbnail_pic = [thumbnail_pic copy];
    
    self.tbmiddle_pic = [thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
}
@end
