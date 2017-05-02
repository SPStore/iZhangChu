//
//  ZCBasicIntroduceViewController.m
//  iZhangChu
//
//  Created by Libo on 17/4/28.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCBasicIntroduceViewController.h"
#import <WebKit/WebKit.h>

@interface ZCBasicIntroduceViewController () <WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, assign) CGFloat progressAcc;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ZCBasicIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://h5.izhangchu.com/Tour.html?app_hideheader=1&user_id=1513438&token=0250CA3EC75E88964CD42F908EB99078&app_exitpage=1"]];
    [self.webView loadRequest:request];
 
}

- (WKWebView *)webView {
    if (_webView == nil) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH-64)];
        _webView.scrollView.backgroundColor = [UIColor clearColor];
        _webView.scrollView.contentInset = UIEdgeInsetsMake(-44, 0, 0, 0);
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
    
    // 移除不想要的标签的某个内容
#warning 问题:h5中的某个标签类名是由class和id共同决定的，该如何更加标准的找到该标签
    NSString *str = @"document.getElementsByClassName('header-wrap hidden')[0].remove();";
    [webView evaluateJavaScript:str completionHandler:nil];
    
    // 获取h5中某个标签的内容
    NSString *headerTitle = @"document.getElementsByClassName('header-title')[0].innerText";
    [webView evaluateJavaScript:headerTitle completionHandler:^(NSString *_Nullable title, NSError * _Nullable error) {
        NSLog(@"---%@",title);
        self.navigationView.title = title;
    }];
    
    self.progressAcc = (1- self.progressView.progress ) / 25;
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
