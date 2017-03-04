//
//  UIBarButtonItem+JXExtension.m
//  JXWeiBo
//
//  Created by 王加祥 on 16/6/16.
//  Copyright © 2016年 Wangjiaxiang. All rights reserved.
//

#import "UIBarButtonItem+JXExtension.h"

@implementation UIBarButtonItem (JXExtension)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName
                         highImageName:(NSString *)highImageName
                                target:(id)target
                                action:(SEL)action {
    // 创建导航栏
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 创建正常状态下按钮
    [button setImage:[UIImage originalImageWithImageName:imageName]
            forState:UIControlStateNormal];
    
    // 创建选中状态下按钮
    [button setImage:[UIImage originalImageWithImageName:highImageName]
            forState:UIControlStateHighlighted];
    
    // 设置按钮的尺寸为背景图片的尺寸
    button.size = button.currentImage.size;
    
    // 监听按钮的点击
    [button addTarget:target
               action:action
     forControlEvents:UIControlEventTouchDown];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                             style:(UIBarButtonItemStyle)style
                            target:(id)target
                            action:(SEL)action {
    
    // 创建按钮
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 创建正常状态下的文字
    [button setTitle:title
            forState:UIControlStateNormal];
    
    // 创建正常状态下的文字
    [button setTitleColor:[UIColor whiteColor]
                 forState:UIControlStateNormal];
    
    // 正常状态下的文字尺寸
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    
    // 选中状态下的文字颜色
    [button setTitleColor:[UIColor lightGrayColor]
                 forState:UIControlStateHighlighted];
    
    // 禁用状态下的文字颜色
    [button setTitleColor:[UIColor lightGrayColor]
                 forState:UIControlStateDisabled];
    
    // 文字自适应
    [button sizeToFit];
    
    // 监听方法
    [button addTarget:target
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
@end
