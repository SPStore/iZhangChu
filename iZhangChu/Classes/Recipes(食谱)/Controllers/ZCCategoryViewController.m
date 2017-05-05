//
//  ZCCategoryViewController.m
//  掌厨
//
//  Created by Libo on 17/4/17.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCCategoryViewController.h"
#import "ZCMacro.h"

@interface ZCCategoryViewController ()

@end

@implementation ZCCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

// 重写父类的网络请求方法
- (void)requestData:(NSMutableDictionary *)params {
    // 先清空父类的字典
    [params removeAllObjects];
    
    params[@"methodName"] = @"CategoryIndex";
    params[@"user_id"] = @"0";
    params[@"token"] = @"0";
    params[@"version"] = @4.92;
    // 调用父类的网络请求
    //[super requestData:params];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end





