//
//  UIBarButtonItem+JXExtension.h
//  JXWeiBo
//
//  Created by 王加祥 on 16/6/16.
//  Copyright © 2016年 Wangjiaxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (JXExtension)
/**
 *  快速设置导航栏上图片
 *
 *  @param imageName     图片名称
 *  @param highImageName 选中图片名称
 *  @param target        目标函数
 *  @param action        方法名
 *
 *  @return 返回导航栏按钮
 */
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName
                         highImageName:(NSString *)highImageName
                                target:(id)target
                                action:(SEL)action;

/**
 *  快速设置导航栏上文字
 *
 *  @param title  导航栏文字
 *  @param style  文字样式
 *  @param target 目标函数
 *  @param action 方法名称
 *
 *  @return 返回导航栏按钮
 */
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                             style:(UIBarButtonItemStyle)style
                            target:(id)target
                            action:(SEL)action;
@end
