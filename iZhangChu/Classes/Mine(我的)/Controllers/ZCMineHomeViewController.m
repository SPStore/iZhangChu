//
//  ZCMineHomeViewController.m
//  掌厨
//
//  Created by Shengping on 17/4/17.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCMineHomeViewController.h"
#import "ZCMineHomeDataSource.h"
#import "ZCMineHomeCell.h"
#import "ZCMineHomeHeaderView.h"
#import "ZCMineSettingViewController.h"
#import "ZCLoginViewController.h"

static NSString * const mindeHomeCell = @"mindeHomeCell";

@interface ZCMineHomeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *groups;

@property (nonatomic, strong) ZCMineHomeHeaderView *headerView;

@end

@implementation ZCMineHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.groups = [ZCMineHomeDataSource dataSource];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = self.headerView;
    
    [self.tableView registerClass:[ZCMineHomeCell class] forCellReuseIdentifier:mindeHomeCell];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZCMineBasicGroup *group = self.groups[section];
    return group.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCMineHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:mindeHomeCell forIndexPath:indexPath];
    ZCMineBasicGroup *group = self.groups[indexPath.section];
    cell.model = group.models[indexPath.row];
    // 设置分割线
    [cell setupSingleLineWithIndexPath:indexPath rowCountInSection:group.models.count sectionCount:self.groups.count];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCMineBasicGroup *group = self.groups[indexPath.section];
    ZCMineBasicModel *model = group.models[indexPath.row];
    if (model.targetControllerClass) {
//        UIViewController *viewController = [[model.targetControllerClass alloc] init];
//        [self.navigationController pushViewController:viewController animated:YES];
        ZCLoginViewController *loginVc = [[ZCLoginViewController alloc] init];
        [self.navigationController pushViewController:loginVc animated:YES];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (ZCMineHomeHeaderView *)headerView {
    
    if (!_headerView) {
        _headerView = [ZCMineHomeHeaderView shareMineHomeHeaderView];
        _headerView.frame = CGRectMake(0, 0, kScreenW, 260);
        WEAKSELF;
        _headerView.clickedBlock = ^(){
            ZCMineSettingViewController *settingVc = [[ZCMineSettingViewController alloc] init];
            [weakSelf.navigationController pushViewController:settingVc animated:YES];
        };
    }
    return _headerView;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStyleGrouped];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = ZCBackgroundColor;
        _tableView.sectionFooterHeight = CGFLOAT_MIN;
        _tableView.sectionHeaderHeight = CGFLOAT_MIN;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.tableFooterView = view;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
