//
//  JXGlobalCell.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/9.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXGlobalCell.h"
#import "JXGlobalItem.h"
#import "JXGlobalArrowItem.h"
#import "JXGlobalSwitchItem.h"
#import "JXGlobalTextItem.h"
#import "JXBageView.h"

@interface JXGlobalCell ()
/** 箭头 */
@property (nonatomic,strong) UIImageView * rightArrow;
/** 开关 */
@property (nonatomic,strong) UISwitch * rightSwitch;
/** 文字 */
@property (nonatomic,strong) UILabel * rightText;
/** 提醒数字 */
@property (nonatomic,strong) JXBageView * bageView;
@end

@implementation JXGlobalCell

#pragma mark - setter
- (UIImageView *)rightArrow{
    if (_rightArrow == nil) {
        _rightArrow =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _rightArrow;
}

- (UISwitch *)rightSwitch{
    if (_rightSwitch == nil) {
        _rightSwitch = [[UISwitch alloc] init];
    }
    return _rightSwitch;
}

- (UILabel *)rightText{
    if (_rightText == nil) {
        _rightText = [[UILabel alloc] init];
        _rightText.font = [UIFont systemFontOfSize:13];
        _rightText.textColor = [UIColor lightGrayColor];
    }
    return _rightText;
}

- (JXBageView *)bageView{
    if (_bageView == nil) {
        _bageView = [[JXBageView alloc] init];
    }
    return _bageView;
}
- (void)setItem:(JXGlobalItem *)item {
    _item = item;
    
    self.imageView.image = [UIImage imageNamed:item.icon];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subTitle;
    
    if (item.bageVaule) {
        self.bageView.bageVaule = item.bageVaule;
        self.accessoryView = self.bageView;
    }else if ([item isKindOfClass:[JXGlobalArrowItem class]]) {
        self.accessoryView = self.rightArrow;
    } else if ([item isKindOfClass:[JXGlobalSwitchItem class]]) {
        self.accessoryView = self.rightSwitch;
    } else if ([item isKindOfClass:[JXGlobalTextItem class]]) {
        JXGlobalTextItem *textItem = (JXGlobalTextItem *)item;
        self.rightText.text = textItem.text;
        self.rightText.size = [textItem.text sizeWithAttributes:@{NSFontAttributeName:self.rightText.font}];
        self.accessoryView = self.rightText;
    } else {
        self.accessoryView = nil;
    }
    
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
        selectView.image = [UIImage resizedImage:@"common_card_middle_background_highlighted "];
        bgView.image = [UIImage resizedImage:@"common_card_middle_background"];
    }
    
    self.selectedBackgroundView = selectView;
    self.backgroundView = bgView;
}
@end
