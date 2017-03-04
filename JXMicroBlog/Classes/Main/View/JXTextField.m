//
//  JXTextField.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2016/12/15.
//  Copyright © 2016年 王加祥. All rights reserved.
//  自定义搜索框

#import "JXTextField.h"

@implementation JXTextField


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *leftImage = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        UIImageView *leftView = [[UIImageView alloc] initWithImage:leftImage];
        leftView.contentMode = UIViewContentModeCenter;
        leftView.size = leftImage.size;
        leftView.w += 10;
        leftView.h += 10;
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.backgroundColor = [UIColor whiteColor];
        self.placeholder = @"搜索";
    }
    return self;
}

+ (instancetype)createSearch {
    JXTextField *textField = [[self alloc] init];
    return textField;
}

@end
