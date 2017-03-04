//
//  JXDiscoveryController.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2016/12/13.
//  Copyright © 2016年 王加祥. All rights reserved.
//

#import "JXDiscoveryController.h"
#import "JXTextField.h" // 搜索框

@interface JXDiscoveryController ()

@end

@implementation JXDiscoveryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRandColor;
    
    JXTextField *textField = [JXTextField createSearch];
    textField.w = kWidth;
    textField.h = 30;
    self.navigationItem.titleView = textField;
    
}

@end
