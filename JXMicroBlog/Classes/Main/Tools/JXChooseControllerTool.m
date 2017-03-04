//
//  JXChooseControllerTool.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/9.
//  Copyright © 2017年 王加祥. All rights reserved.
//  选择根控制器工具

#import "JXChooseControllerTool.h"
#import "JXNewFeatureController.h" // 新特性
#import "JXTabBarController.h"

@implementation JXChooseControllerTool

+ (void)chooseController {
    
    NSString * versionKey = @"CFBundleShortVersionString";
    // 从沙河中取出上次存储的软件版本号（取出上次的使用记录）
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * lastVersion = [defaults objectForKey:versionKey];
    
    NSDictionary * versionDict = [NSBundle mainBundle].infoDictionary;
    NSString * currentVersion = versionDict[versionKey];
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    if (![currentVersion isEqualToString:lastVersion]) { // 如果是第一次使用，就进入版本新特性控制器
        
        window.rootViewController = [[JXNewFeatureController alloc] init];
        // 将当前版本号存到沙盒中
        [defaults setObject:currentVersion forKey:versionKey];
        [defaults synchronize];
        
    } else {
        window.rootViewController = [[JXTabBarController alloc] init];
    }
}

@end
