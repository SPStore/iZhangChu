//
//  ZCSuitableViewController.m
//  iZhangChu
//
//  Created by Libo on 17/6/9.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCSuitableViewController.h"
#import "ZCMacro.h"
#import "ZCDishesSuitableModel.h"
#import "ZCSuitableCell.h"

@interface ZCSuitableViewController ()

@property (nonatomic, strong) ZCDishesSuitableModel *suitableModel;

@end

@implementation ZCSuitableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCSuitableCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZCSuitableCell class])];
    
    [self requestData];
}

- (void)requestData {
    NSMutableDictionary *params = [NSMutableDictionary dictionary ];
    params[@"methodName"] = @"DishesSuitable";
    params[@"dishes_id"] = self.dishes_id;
    params[@"user_id"] = @"0";
    params[@"token"] = @"0";
    params[@"version"] = @4.92;
    
    [[SPHTTPSessionManager shareInstance] POST:ZCHOSTURL params:params success:^(id  _Nonnull responseObject) {
        
        ZCDishesSuitableModel *suitableModel = [ZCDishesSuitableModel mj_objectWithKeyValues:responseObject[@"data"][@"material"]];
        self.suitableModel = suitableModel;
        
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // 固定3个
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return self.suitableModel.suitable_with.count;
    } else {
        return self.suitableModel.suitable_not_with.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZCSuitableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZCSuitableCell class]) forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.model = self.suitableModel;
    } else if (indexPath.section == 1) {
        cell.item = self.suitableModel.suitable_with[indexPath.row];
    } else {
        cell.item = self.suitableModel.suitable_not_with[indexPath.row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 200;
    } else {
        return 70;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section != 0) {
         return 31;
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        UIView *labelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 31)];
        labelView.backgroundColor = ZCBackgroundColor;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, kScreenW, 21)];
        label.backgroundColor = [UIColor whiteColor];
        NSString *tagTitle;
        UIColor *color;
        if (section == 1) {
            tagTitle = @"相宜";
            color = ZCColorRGBA(0, 148, 0, 1);
        } else {
            tagTitle = @"相克";
            color = [UIColor redColor];
        }
        NSString *sectionTitle = [NSString stringWithFormat:@"与%@搭配%@的食材",self.suitableModel.material_name,tagTitle];
        NSMutableAttributedString *sectionAttTitle = [[NSMutableAttributedString alloc] initWithString:sectionTitle];

        [sectionAttTitle addAttribute:NSForegroundColorAttributeName value:color range:[sectionTitle rangeOfString:tagTitle]];
        
        label.attributedText = sectionAttTitle;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.alpha = 0.8;
        [labelView addSubview:label];
        return labelView;
    }
    return nil;
}

@end
