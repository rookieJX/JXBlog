//
//  JXUserModel.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/14.
//  Copyright © 2017年 王加祥. All rights reserved.
//  用户模型

#import <Foundation/Foundation.h>

@interface JXUserModel : NSObject

/** 友好显示名称 */
@property (nonatomic,copy) NSString * name;
/** 用户头像地址（中图），50×50像素 */
@property (nonatomic,copy) NSString * profile_image_url;
/** 类型 */
@property (nonatomic,assign) NSInteger mbtype;
/** 等级 */
@property (nonatomic,assign) NSInteger mbrank;
/** 是否是会员 */
@property (nonatomic,assign,getter=isVip,readonly) BOOL vip;
@end
