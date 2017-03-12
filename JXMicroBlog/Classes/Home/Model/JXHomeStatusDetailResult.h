//
//  JXHomeStatusDetailResult.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/12.
//  Copyright © 2017年 王加祥. All rights reserved.
//  首页详细评论返回的结果

#import <Foundation/Foundation.h>


@interface JXHomeStatusDetailResult : NSObject

/** 评论详情 */
@property (nonatomic,strong) NSArray * comments;

@end

#import "JXUserModel.h"
#import "JXStatus.h"

@interface JXHomeStatusDetailCommentResult : NSObject

/** 评论创建时间 */
@property (nonatomic,copy) NSString * created_at;
/** 评论的ID */
@property (nonatomic,strong) NSNumber * commentID;
/** 评论的内容*/
@property (nonatomic,copy) NSString * text;
/** 评论的来源 */
@property (nonatomic,copy) NSString * source;
/** 评论作者的用户信息字段 详细 */
@property (nonatomic,strong) JXUserModel * user;
/** 评论的MID */
@property (nonatomic,copy) NSString * mid;
/** 字符串型的评论ID */
@property (nonatomic,copy) NSString * idstr;
/** 评论的微博信息字段 详细 */
@property (nonatomic,strong) JXStatus * status;
/** 评论来源评论，当本评论属于对另一评论的回复时返回此字段 */
@property (nonatomic,copy) NSString * reply_comment;
@end
