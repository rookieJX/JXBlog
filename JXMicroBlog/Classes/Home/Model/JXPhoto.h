//
//  JXPhoto.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/14.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXPhoto : NSObject
/** 缩略图 */
@property (nonatomic,copy) NSString * thumbnail_pic;
/** 放大图 */
@property (nonatomic,copy) NSString * tbmiddle_pic;
@end
