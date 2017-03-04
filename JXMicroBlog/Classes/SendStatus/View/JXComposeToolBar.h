//
//  JXComposeToolBar.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/18.
//  Copyright © 2017年 王加祥. All rights reserved.
//  自定义工具条

#import <UIKit/UIKit.h>

@protocol JXComposeToolBarDelegate <NSObject>

@optional
- (void)composeToolBarDidSelectButtonType:(ComposeType)tpe;

@end

@interface JXComposeToolBar : UIView
/** 点击选中代理 */
@property (nonatomic,weak) id<JXComposeToolBarDelegate> delegate;
/** 是否是表情 */
@property (nonatomic,assign,getter=isShowEmotion) BOOL showEmotion;
@end
