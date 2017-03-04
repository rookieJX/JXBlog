//
//  JXHomeStatusResultModel.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/19.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXHomeStatusResultModel.h"
#import "JXStatus.h"

@implementation JXHomeStatusResultModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"statuses":[JXStatus class]
             };
}
@end
