//
//  ZCBasicIntroduceViewController.m
//  iZhangChu
//
//  Created by Libo on 17/4/28.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCFoodLiveViewController.h"

@interface ZCFoodLiveViewController ()

@end

@implementation ZCFoodLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.urlString = @"http://www.meipai.com/user/1047577070";
    
}

// 如果不添加这个，那webview跳转不了AppStore
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    [super webView:webView decidePolicyForNavigationAction:navigationAction decisionHandler:decisionHandler];
    
    if ([webView.URL.absoluteString hasPrefix:@"https://itunes.apple.com"]) {
        //        [[UIApplication sharedApplication] openURL:navigationAction.request.URL options:nil completionHandler:nil];
        //        decisionHandler(WKNavigationActionPolicyCancel);
    }else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
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
