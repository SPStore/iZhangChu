//
//  ZCBasicIntroduceViewController.m
//  iZhangChu
//
//  Created by Libo on 17/4/28.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCBasicIntroduceViewController.h"

@interface ZCBasicIntroduceViewController ()

@end

@implementation ZCBasicIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.urlString = @"http://h5.izhangchu.com/Tour.html?app_hideheader=1&user_id=1513438&token=0250CA3EC75E88964CD42F908EB99078&app_exitpage=1";
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
    
    // 移除不想要的标签的某个内容，这里去除广告
#warning 问题:h5中的某个标签类名是由class和id共同决定的，该如何更加标准的找到该标签
    NSString *str = @"document.getElementsByClassName('footer-app layout-footer')[0].remove();";
    [webView evaluateJavaScript:str completionHandler:nil];
    
    // 获取h5中某个标签的内容
    NSString *headerTitle = @"document.getElementsByClassName('header-title')[0].innerText";
    [webView evaluateJavaScript:headerTitle completionHandler:^(NSString *_Nullable title, NSError * _Nullable error) {
        
        self.navigationView.title = title;
    }];
    
}

@end
