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
/** 行号 */
@property (nonatomic,strong) NSIndexPath * indexPath;

- (void)setIndexPath:(NSIndexPath *)indexPath totalRowsInSection:(NSInteger)totalRows;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
