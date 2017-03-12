//
//  JXHomeStatusDetailResult.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/12.
//  Copyright © 2017年 王加祥. All rights reserved.
//  

#import "JXHomeStatusDetailResult.h"
@implementation JXHomeStatusDetailResult

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"comments" : [JXHomeStatusDetailCommentResult class]
             };
}

@end


@implementation JXHomeStatusDetailCommentResult

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"commentID":@"id"
             };
}


@end
