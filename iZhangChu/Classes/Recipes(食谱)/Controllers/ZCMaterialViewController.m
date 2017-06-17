//
//  ZCMaterialViewController.m
//  iZhangChu
//
//  Created by Libo on 17/6/9.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCMaterialViewController.h"
#import "ZCMacro.h"
#import "ZCDishesMaterialModel.h"
#import "ZCMaterialItemCell.h"
#import "ZCSpiceItemCell.h"

@interface ZCMaterialViewController ()

@property (nonatomic, strong) NSArray *groups;

@end

@implementation ZCMaterialViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCMaterialItemCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZCMaterialItemCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCSpiceItemCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZCSpiceItemCell class])];
    
    [self requestData];
}

- (void)requestData {
    NSMutableDictionary *params = [NSMutableDictionary dictionary ];
    params[@"methodName"] = @"DishesMaterial";
    params[@"dishes_id"] = self.dishes_id;
    params[@"user_id"] = @"0";
    params[@"token"] = @"0";
    params[@"version"] = @4.92;
    
    [[SPHTTPSessionManager shareInstance] POST:ZCHOSTURL params:params success:^(id  _Nonnull responseObject) {
        ZCDishesMaterialModel *materialModel = [ZCDishesMaterialModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.groups = @[materialModel.material,materialModel.spices];
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.groups[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *items = self.groups[indexPath.section];
    
    if (indexPath.section == 0) {
        ZCMaterialItemCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZCMaterialItemCell class]) forIndexPath:indexPath];
        cell.materialItem = items[indexPath.row];
        return cell;
    } else if (indexPath.section == 1) {
        ZCSpiceItemCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZCSpiceItemCell class]) forIndexPath:indexPath];
        cell.spiceItem = items[indexPath.row];
        return cell;

    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 200;
    } else {
        return 44;
    }
}

@end
