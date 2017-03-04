//
//  JXUserModel.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/14.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXUserModel.h"

@implementation JXUserModel
- (BOOL)isVip {
    return self.mbtype > 2;
}
@end
