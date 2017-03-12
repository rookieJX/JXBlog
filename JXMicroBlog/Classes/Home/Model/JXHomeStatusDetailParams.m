//
//  JXHomeStatusDetailParams.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/12.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXHomeStatusDetailParams.h"

@implementation JXHomeStatusDetailParams
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"statusID":@"id"
             };
}
@end
