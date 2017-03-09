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
@end
