//
//  ZCWebViewController.h
//  iZhangChu
//
//  Created by Libo on 17/5/11.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCBasicViewController.h"
#import <WebKit/WebKit.h>

@interface ZCWebViewController : ZCBasicViewController<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) NSString *urlString;

@end
