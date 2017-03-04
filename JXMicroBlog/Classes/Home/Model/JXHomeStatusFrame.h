//
//  JXHomeStatusFrame.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/21.
//  Copyright © 2017年 王加祥. All rights reserved.
//  整个微博尺寸

#import <Foundation/Foundation.h>

@class JXStatus,JXHomeDetailFrame;

@interface JXHomeStatusFrame : NSObject

/** 详细微博 */
@property (nonatomic,strong) JXHomeDetailFrame * detailFrame;
/** 底部工具条 */
@property (nonatomic,assign) CGRect toolbarFrame;
/** cell高度 */
@property (nonatomic,assign) CGFloat cellHeight;

/** 微博 */
@property (nonatomic,strong) JXStatus * stauts;
@end
