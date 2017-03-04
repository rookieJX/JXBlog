//
//  JXHomeUnreadeCountModel.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/19.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXHomeUnreadeCountModel.h"

@implementation JXHomeUnreadeCountModel
- (NSInteger)messageCount {
    
    return  self.cmt + self.dm + self.mention_cmt + self.mention_status;
}

- (NSInteger)totalCount {
    return self.status;
}
@end
