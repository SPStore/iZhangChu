//
//  ZCNavigationController.m
//  掌厨
//
//  Created by Libo on 17/4/17.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCNavigationController.h"
#import "ZCBasicViewController.h"

@interface ZCNavigationController ()

@end

@implementation ZCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        /* 当push的时候自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        ZCBasicViewController *vc = (ZCBasicViewController *)viewController;
        [vc.navigationView.leftButton setImage:[UIImage imageNamed:@"nav_back_black"] forState:UIControlStateNormal];
        [vc.navigationView.leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    // 必须super
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}



@end
