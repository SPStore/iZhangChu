//
//  ZCCommensenseViewController.m
//  iZhangChu
//
//  Created by Libo on 17/6/9.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCCommensenseViewController.h"
#import "ZCMacro.h"
#import "ZCCommensenseCell.h"
#import "ZCDishesCommensenseModel.h"

@interface ZCCommensenseViewController ()

@property (nonatomic, strong) ZCDishesCommensenseModel *commensenseModel;

@end

@implementation ZCCommensenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCCommensenseCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZCCommensenseCell class])];
    
    [self requestData];
}


- (void)requestData {
    NSMutableDictionary *params = [NSMutableDictionary dictionary ];
    params[@"methodName"] = @"DishesCommensense";
    params[@"dishes_id"] = self.dishes_id;
    params[@"user_id"] = @"0";
    params[@"token"] = @"0";
    params[@"version"] = @4.92;
    
    [[SPHTTPSessionManager shareInstance] POST:ZCHOSTURL params:params success:^(id  _Nonnull responseObject) {
        ZCDishesCommensenseModel *commensenseModel = [ZCDishesCommensenseModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.commensenseModel = commensenseModel;
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // 固定3个
    if (self.commensenseModel) {
       return 3;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.commensenseModel) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZCCommensenseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZCCommensenseCell class]) forIndexPath:indexPath];
    
    cell.indexPath = indexPath;
    cell.model = self.commensenseModel;
  
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 200;
    } else {
        return UITableViewAutomaticDimension;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}


@end
