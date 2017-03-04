//
//  JXTabBar.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/7.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXTabBar : UITabBar
/** 中间按钮 */
@property (nonatomic,copy) void(^CenterBtnClickBlock)();
@end
