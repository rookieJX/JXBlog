//
//  JXHomeDetailViewController.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/11.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JXStatus;

@interface JXHomeDetailViewController : UITableViewController
/** 微博数据 */
@property (nonatomic,strong) JXStatus * status;
@end
