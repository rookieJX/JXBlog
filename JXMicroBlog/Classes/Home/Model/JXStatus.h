//
//  JXStatus.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/14.
//  Copyright © 2017年 王加祥. All rights reserved.
//  微博

#import <Foundation/Foundation.h>

@class JXUserModel,JXPhoto;

@interface JXStatus : NSObject
/** 微博创建时间 */
@property (nonatomic,copy) NSString * created_at;
/** 字符串型的微博ID */
@property (nonatomic,copy) NSString * idstr;
/** 微博信息内容 */
@property (nonatomic,copy) NSString * text;
/** 微博信息内容富文本 */
@property (nonatomic,copy) NSAttributedString * attributeText;
/** 微博来源 */
@property (nonatomic,copy) NSString * source;
/** 缩略图片地址，没有时不返回此字段 */
@property (nonatomic,copy) NSString * thumbnail_pic;
/** 中等尺寸图片地址，没有时不返回此字段 */
@property (nonatomic,copy) NSString * bmiddle_pic;
/** 原始图片地址，没有时不返回此字段 */
@property (nonatomic,copy) NSString * original_pic;
/** 微博作者的用户信息字段 详细 */
@property (nonatomic,strong) JXUserModel * user;
/** 被转发的原微博信息字段，当该微博为转发微博时返回 详细 */
@property (nonatomic,strong) JXStatus * retweeted_status;
/** 转发数 */
@property (nonatomic,assign) NSInteger reposts_count;
/** 评论数 */
@property (nonatomic,assign) NSInteger comments_count;
/** 表态数 */
@property (nonatomic,assign) NSInteger attitudes_count;
/** 数组内为模型 */
@property (nonatomic,strong) NSArray * pic_urls;

/** 判断是否是转发微博 */
@property (nonatomic,assign,getter=isRetweeted) BOOL retweeted;
/** 是否是详细的转发微博 */
@property (nonatomic,assign,getter=isDetail) BOOL detail;

@end
