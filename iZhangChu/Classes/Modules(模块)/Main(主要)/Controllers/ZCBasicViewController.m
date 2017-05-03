//
//  ZCBasicViewController.m
//  掌厨
//
//  Created by Libo on 17/4/17.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCBasicViewController.h"

@interface ZCBasicViewController ()

@end

@implementation ZCBasicViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 隐藏系统的导航栏
    self.navigationController.navigationBar.hidden = YES;
    
    // 这行代码是调用navigationView的setter方法和getter方法
    self.navigationView = self.navigationView;
}

// 自定义的navigationBar
- (ZCNavigationView *)navigationView {
    if (!_navigationView) {
        _navigationView = [ZCNavigationView sharedInstance];
        _navigationView.backgroundColor = [UIColor whiteColor];
    }
    return _navigationView;
}

- (void)setNavigationView:(ZCNavigationView *)navigationView {
    _navigationView = navigationView;
    [self.view addSubview:self.navigationView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end



@interface ZCNavigationView() {
    UIView *_centerView;
}
@property (nonatomic, strong) UILabel *titleLabel;
@end

