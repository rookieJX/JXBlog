//
//  JXHomeStatusResultModel.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/19.
//  Copyright © 2017年 王加祥. All rights reserved.
//  加载首页模型返回的结果

#import <Foundation/Foundation.h>

@interface JXHomeStatusResultModel : NSObject
/** 返回微博数组 */
@property (nonatomic,strong) NSArray * statuses;
/** 近期的微博总数 */
@property (nonatomic,assign) NSInteger total_number;
@end
