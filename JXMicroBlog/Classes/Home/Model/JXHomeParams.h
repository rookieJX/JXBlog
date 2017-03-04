//
//  JXHomeParams.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/14.
//  Copyright © 2017年 王加祥. All rights reserved.
//  请求首页关注信息接口

#import <Foundation/Foundation.h>

@interface JXHomeParams : NSObject
/** 采用OAuth授权方式为必填参数，OAuth授权后获得 */
@property (nonatomic,copy) NSString * access_token;
/** 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0 */
@property (nonatomic,assign) NSInteger since_id;
/** 若指定此参数，则返回ID小于或等于max_id的微博，默认为0 */
@property (nonatomic,assign) NSInteger max_id;
/** 单页返回的记录条数，最大不超过100，默认为20 */
@property (nonatomic,assign) NSInteger count;
/** 返回结果的页码，默认为1 */
@property (nonatomic,assign) NSInteger page;
/** 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0 */
@property (nonatomic,assign) NSInteger base_app;
/** 过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0 */
@property (nonatomic,assign) NSInteger feature;
/** 返回值中user字段开关，0：返回完整user字段、1：user字段仅返回user_id，默认为0 */
@property (nonatomic,assign) NSInteger trim_user;
@end
