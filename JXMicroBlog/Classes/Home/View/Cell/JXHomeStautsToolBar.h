//
//  JXHomeStautsToolBar.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/20.
//  Copyright © 2017年 王加祥. All rights reserved.
//  首页cell底部工具条

#import <UIKit/UIKit.h>

@class JXHomeStautsToolBar,JXStatus;

@protocol JXHomeStautsToolBarDelegate <NSObject>

@optional
- (void)homeStatusToolbar:(JXHomeStautsToolBar *)toolbar didSelectWithType:(HomeStatusType)type;

@end

@interface JXHomeStautsToolBar : UIView
/** 点击代理 */
@property (nonatomic,weak) id<JXHomeStautsToolBarDelegate> delegate;
/** 微博 */
@property (nonatomic,strong) JXStatus * status;
@end
