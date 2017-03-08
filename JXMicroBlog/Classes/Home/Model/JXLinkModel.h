//
//  JXLinkModel.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/8.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXLinkModel : NSObject
/** 文字 */
@property (nonatomic,copy) NSString * text;
/** 范围 */
@property (nonatomic,assign) NSRange range;
/** 连接的矩形框 */
@property (nonatomic,strong) NSArray * rects;
@end
