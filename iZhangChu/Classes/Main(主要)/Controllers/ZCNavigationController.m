//
//  ZCNavigationController.m
//  掌厨
//
//  Created by Shengping on 17/4/17.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCNavigationController.h"

@interface ZCNavigationController ()

@end

@implementation ZCNavigationController

+ (void)initialize {

    UINavigationBar *bar = [UINavigationBar appearance];
    // key：NS****AttributeName
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    // 设置导航栏的标题颜色
    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithWhite:0 alpha:0.8];
    // 设置导航栏的标题字体,并加粗
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:16];
    [bar setTitleTextAttributes:textAttrs];
    // 设置导航栏的barButtonItem的图片颜色
    [bar setTintColor:[UIColor grayColor]];

    [bar setBarTintColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 当第一个子控件为scrollView时，顶部限制压缩64
    viewController.automaticallyAdjustsScrollViewInsets = NO;
    
    if (self.viewControllers.count > 0) {
        /* 当push的时候自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back_black"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        self.interactivePopGestureRecognizer.delegate = (id)self;
    }
    // 必须super
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}


@end
