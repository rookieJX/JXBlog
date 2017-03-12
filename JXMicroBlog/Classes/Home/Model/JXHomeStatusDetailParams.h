//
//  JXHomeStatusDetailParams.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/12.
//  Copyright © 2017年 王加祥. All rights reserved.
//  获取某一条微博的评论

#import <Foundation/Foundation.h>

@interface JXHomeStatusDetailParams : NSObject

/** 采用OAuth授权方式为必填参数，OAuth授权后获得 */
@property (nonatomic,copy) NSString * access_token;
/** 需要查询的微博ID */
@property (nonatomic,copy) NSString *statusID;
/** 若指定此参数，则返回ID比since_id大的评论（即比since_id时间晚的评论），默认为0 */
@property (nonatomic,copy) NSString *since_id;
/** 若指定此参数，则返回ID小于或等于max_id的评论，默认为0 */
@property (nonatomic,strong) NSNumber *max_id;
/** 单页返回的记录条数，默认为50。 */
@property (nonatomic,strong) NSNumber *count;
/** 返回结果的页码，默认为1 */
@property (nonatomic,strong) NSNumber *page;
/** 作者筛选类型，0：全部、1：我关注的人、2：陌生人，默认为0 */
@property (nonatomic,strong) NSNumber *filter_by_author;
@end
