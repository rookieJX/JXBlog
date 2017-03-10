//
//  JXGlobalCell.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/9.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXGlobalCell.h"
#import "JXGlobalItem.h"


@implementation JXGlobalCell

- (void)setItem:(JXGlobalItem *)item {
    _item = item;
    
    self.imageView.image = [UIImage imageNamed:item.icon];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subTitle;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:13];
        
        UIImageView *selectView = [[UIImageView alloc] init];
        UIImageView *bgView = [[UIImageView alloc] init];
        
        self.selectedBackgroundView = selectView;
        self.backgroundView = bgView;
        
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *globalIdentifierCell = @"globalIdentifierCell";
    JXGlobalCell *globalCell = [tableView dequeueReusableCellWithIdentifier:globalIdentifierCell];
    if (globalCell == nil) {
        globalCell = [[JXGlobalCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:globalIdentifierCell];
    }
    return globalCell;
}


#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + 10;
}

- (void)setFrame:(CGRect)frame {
    
    frame.origin.y -= 25;
    
    [super setFrame:frame];
}

- (void)setIndexPath:(NSIndexPath *)indexPath totalRowsInSection:(NSInteger)totalRows{
    
    UIImageView *selectView = (UIImageView *)self.selectedBackgroundView ;
    UIImageView *bgView = (UIImageView *)self.backgroundView;
    
    if (totalRows == 1) {
        selectView.image = [UIImage resizedImage:@"common_card_background_highlighted"];
        bgView.image = [UIImage resizedImage:@"common_card_background"];
    } else if (indexPath.row == 0) {
        selectView.image = [UIImage resizedImage:@"common_card_top_background_highlighted"];
        bgView.image = [UIImage resizedImage:@"common_card_top_background"];
    } else if (indexPath.row == totalRows - 1) {
        selectView.image = [UIImage resizedImage:@"common_card_bottom_background_highlighted"];
        bgView.image = [UIImage resizedImage:@"common_card_bottom_background"];
    } else {
        selectView.image = [UIImage resizedImage:@"common_card_middle_background_highlighted"];
        bgView.image = [UIImage resizedImage:@"common_card_middle_background"];
    }
    
    self.selectedBackgroundView = selectView;
    self.backgroundView = bgView;
}
@end
