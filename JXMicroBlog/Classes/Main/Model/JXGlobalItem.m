//
//  JXGlobalItem.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/9.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXGlobalItem.h"

@implementation JXGlobalItem

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon {
    JXGlobalItem *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    return item;
}


+ (instancetype)itemWithTitle:(NSString *)title {
    return [self itemWithTitle:title icon:nil]; 
}

@end
