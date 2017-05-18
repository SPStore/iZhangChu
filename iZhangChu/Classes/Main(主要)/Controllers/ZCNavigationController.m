//
//  ZCNavigationController.m
//  掌厨
//
//  Created by Shengping on 17/4/17.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCNavigationController.h"
#import "ZCBasicViewController.h"

@interface ZCNavigationController ()

@end

@implementation ZCNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if (self.viewControllers.count > 0) {
        ZCBasicViewController *vc = (ZCBasicViewController *)viewController;
        /* 当push的时候自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
           
        [vc.navigationView.leftButton setImage:[UIImage imageNamed:@"nav_back_black"] forState:UIControlStateNormal];
        [vc.navigationView.leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
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
