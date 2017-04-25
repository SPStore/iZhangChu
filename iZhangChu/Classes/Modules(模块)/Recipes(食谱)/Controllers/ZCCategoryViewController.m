//
//  ZCCategoryViewController.m
//  掌厨
//
//  Created by Libo on 17/4/17.
//  Copyright © 2017年 iDress. All rights reserved.
//



// 热门搜索
// http://api.izhangchu.com/?appVersion=4.92&sysVersion=10.2.1&devModel=iPhone
//  methodName = SearchHot , token=0   user_id=0   version=4.92
#import "ZCCategoryViewController.h"
#import "ZCMacro.h"

@interface ZCCategoryViewController ()

@end

@implementation ZCCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary ];
    params[@"methodName"] = @"CategoryIndex";
    params[@"user_id"] = @"0";
    params[@"token"] = @"0";
    params[@"version"] = @4.92;

    [self requestData:params]; // 调用父类的数据请求方法
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end





