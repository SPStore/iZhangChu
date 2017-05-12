//
//  ZCBasicIntroduceViewController.m
//  iZhangChu
//
//  Created by Libo on 17/4/28.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCBasicIntroduceViewController.h"


@interface ZCWebViewController () 
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, assign) CGFloat progressAcc;
@property (nonatomic, strong) NSTimer *timer;
//@property (nonatomic, strong) WKWebViewConfiguration *config;
@end

@implementation ZCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view insertSubview:self.webView atIndex:0];
    [self.view addSubview:self.progressView];
 
}

- (void)setUrlString:(NSString *)urlString {
    _urlString = [urlString copy];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self.webView loadRequest:request];
}

- (WKWebView *)webView {
    if (_webView == nil) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, kScreenW, kScreenH-20)];
        _webView.scrollView.backgroundColor = [UIColor clearColor];
        _webView.navigationDelegate = self;
    }
    return _webView;
}

- (UIProgressView *)progressView {
    
    if (!_progressView) {
        // 高度不给都行，不论给多大都是1
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, 1)];
        _progressView.tintColor = ZCGlobalColor;
        _progressView.trackTintColor = [UIColor clearColor];
    }
    
    return _progressView;
}


// 如果不添加这个，那webview跳转不了AppStore
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if ([webView.URL.absoluteString hasPrefix:@"https://itunes.apple.com"]) {
        //        [[UIApplication sharedApplication] openURL:navigationAction.request.URL options:nil completionHandler:nil];
        //        decisionHandler(WKNavigationActionPolicyCancel);
    }else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    self.progressView.progress = 0;
    self.progressView.hidden = NO;
    self.progressAcc = 0;
    if (self.timer) {
        [self.timer invalidate];
        
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.0167 target:self selector:@selector(progressCallback) userInfo:nil repeats:YES];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {

}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {

    self.progressAcc = (1- self.progressView.progress ) / 25;
    
    // 获取h5中某个标签的内容
    NSString *headerTitle = @"document.getElementsByClassName('header-title')[0].innerText";
    [webView evaluateJavaScript:headerTitle completionHandler:^(NSString *_Nullable title, NSError * _Nullable error) {
        
        self.navigationView.title = title;
    }];
}

- (void)progressCallback {
    float progress = self.progressView.progress;
    if (self.progressAcc > 0) {
        if (progress >= 1) {
            [self.timer invalidate];
            self.timer = nil;
            self.progressView.hidden = YES;
            self.progressAcc = 0;
            return;
        }
        progress += self.progressAcc;
        if (progress > 1) {
            progress = 1;
        }
    }else if(progress < 0.95){
        if ((progress += (0.95 - progress)*0.01) > 0.95) {
            progress = 0.95;
        }
    }
    self.progressView.progress = progress;
}


@end
