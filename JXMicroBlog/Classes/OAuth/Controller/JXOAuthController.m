//
//  JXOAuthController.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/12.
//  Copyright © 2017年 王加祥. All rights reserved.
//  授权控制器

#import "JXOAuthController.h"
#import "JXOAuthGetTokenParams.h" // 获取token参数
#import "JXChooseControllerTool.h" // 选择根控制器

@interface JXOAuthController ()<UIWebViewDelegate>

@end

@implementation JXOAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:kScreen];
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=2026678657&redirect_uri=https://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    webView.delegate = self;
    [self.view addSubview:webView];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlStr = request.URL.absoluteString;
    JXLog(@"%@",urlStr);
    NSRange range = [urlStr rangeOfString:@"https://www.baidu.com/?code="];
    if (range.location != NSNotFound) {
        NSInteger index = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:index];
        [self getAccesstokenWithCode:code];
        return NO;
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showMessage:@"正在加载..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [MBProgressHUD hideHUD];
}

- (void)getAccesstokenWithCode:(NSString *)code {
    JXOAuthGetTokenParams *getOAuthParams = [[JXOAuthGetTokenParams alloc] init];
    getOAuthParams.client_id = @"2026678657";
    getOAuthParams.client_secret = @"6cf9a5e5cdb8913269d8e0d4305c73c5";
    getOAuthParams.grant_type = @"authorization_code";
    getOAuthParams.code = code;
    getOAuthParams.redirect_uri = @"https://www.baidu.com";
    
    [JXAccountTool getTokenWithParams:getOAuthParams
                              success:^(JXAccount *account) {
                                  [MBProgressHUD hideHUD];
                                  [JXAccountTool saveAccount:account];
                                  [JXChooseControllerTool chooseController];
                              } failure:^(NSError *error) {
                                  [MBProgressHUD hideHUD];
                              }];
//    
//    [JXHTTPTool POST:kOAuthGetToken params:getOAuthParams.mj_keyValues progress:nil success:^(NSDictionary * responseObj) {
//        [MBProgressHUD hideHUD];
//        JXLog(@"%@",responseObj);
//        JXAccount *account = [JXAccount accountWithDict:responseObj];
//        [JXAccountTool saveAccount:account];
//        [JXChooseControllerTool chooseController];
//    } failure:^(NSError *error) {
//        [MBProgressHUD hideHUD];
//    }];
}
@end
