//
//  JXHomeStatusCell.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/20.
//  Copyright © 2017年 王加祥. All rights reserved.
//  首页cell

#import <UIKit/UIKit.h>

@class JXHomeStatusFrame;

@protocol JXHomeStatusCellDelegate <NSObject>

@optional
- (void)homeStatusCellSelectWithType:(HomeStatusType)type;

@end


@interface JXHomeStatusCell : UITableViewCell
/** cellFrame */
@property (nonatomic,strong) JXHomeStatusFrame * statusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 点击代理 */
@property (nonatomic,weak) id<JXHomeStatusCellDelegate> delegate;
@end
