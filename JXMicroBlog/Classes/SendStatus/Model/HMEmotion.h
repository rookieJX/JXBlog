//
//  HMEmotion.h
//  黑马微博
//
//  Created by apple on 14-7-15.
//  Copyright (c) 2014年 heima. All rights reserved.
//  表情

#import <Foundation/Foundation.h>

@interface HMEmotion : NSObject<NSCoding>
/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;
/** 表情的文字描述 */
@property (nonatomic, copy) NSString *cht;
/** 表情的文png图片名 */
@property (nonatomic, copy) NSString *png;
/** emoji表情的编码 */
@property (nonatomic, copy) NSString *code;
/** 存放表情的文件夹 */
@property (nonatomic,copy) NSString * floder;
/** emoji表情 */
@property (nonatomic,copy) NSString * emoji;
@end
