//
//  JXGlobalCell.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/9.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JXGlobalItem;

@interface JXGlobalCell : UITableViewCell

/** 模型 */
@property (nonatomic,strong) JXGlobalItem * item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
