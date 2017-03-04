//
//  JXHomeUnreadeCountParam.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/19.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXHomeUnreadeCountParam.h"

@implementation JXHomeUnreadeCountParam
- (instancetype)init
{
    self = [super init];
    if (self) {
        JXAccount *account = [JXAccountTool account];
        self.access_token = account.access_token;
    }
    return self;
}

+ (instancetype)params {
    
    return [[self alloc] init];
}
@end
