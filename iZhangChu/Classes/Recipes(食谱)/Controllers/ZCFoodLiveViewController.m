//
//  ZCBasicIntroduceViewController.m
//  iZhangChu
//
//  Created by Shengping on 17/4/28.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCFoodLiveViewController.h"

@interface ZCFoodLiveViewController ()

@end

@implementation ZCFoodLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.urlString = @"http://www.meipai.com/user/1047577070";
    
    self.navigationItem.title = @"美食直播";
    
    self.webView.frame = CGRectMake(0, 64, kScreenW, kScreenH-64);
}

// 如果不添加这个，那webview跳转不了AppStore
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    [super webView:webView decidePolicyForNavigationAction:navigationAction decisionHandler:decisionHandler];

}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [super webView:webView didStartProvisionalNavigation:navigation];

}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [super webView:webView didFailNavigation:navigation withError:error];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [super webView:webView didFinishNavigation:navigation];
    
}

@end
