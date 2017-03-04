//
//  JXPopView.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/7.
//  Copyright © 2017年 王加祥. All rights reserved.
//  点击弹出菜单

#import <UIKit/UIKit.h>

@interface JXPopView : UIView

// 初始化
- (instancetype)initWithPopView:(UIView *)view;
// 显示视图大小
- (void)showPopViewRect:(CGRect)rect;

@end
