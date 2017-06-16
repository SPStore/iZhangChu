//
//  ZCBasicViewController.m
//  掌厨
//
//  Created by Shengping on 17/4/17.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCBasicViewController.h"

@interface ZCBasicViewController ()

@end

@implementation ZCBasicViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 隐藏系统的导航栏
    //self.navigationController.navigationBar.hidden = YES;

}

- (ZCNavigationView *)navigationView {
    if (!_navigationView) {
        // 不设置frame就是默认(0,0,screenW,64)
        _navigationView = [[ZCNavigationView alloc] init];
        [self.view addSubview:_navigationView];
    }
    return _navigationView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end




