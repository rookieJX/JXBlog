//
//  JXHomeDetailTopToolbar.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/11.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JXHomeDetailTopToolbarType) {
    JXHomeDetailTopToolbarComent = 1000,
    JXHomeDetailTopToolbarForward,
    JXHomeDetailTopToolbarPraise
};

@class JXHomeDetailTopToolbar,JXStatus;

@protocol JXHomeDetailTopToolbarDelegate <NSObject>

@optional
- (void)topToolbar:(JXHomeDetailTopToolbar *)toolbar didClickButtonType:(JXHomeDetailTopToolbarType)type;

@end

@interface JXHomeDetailTopToolbar : UIView
/** 代理 */
@property (nonatomic,weak) id<JXHomeDetailTopToolbarDelegate> delegate;
/** 微博 */
@property (nonatomic,strong) JXStatus * status;
@end
