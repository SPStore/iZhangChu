//
//  ZCMineSettingViewController.m
//  iZhangChu
//
//  Created by Libo on 17/5/13.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCMineSettingViewController.h"
#import "ZCMineHomeCell.h"
#import "ZCMineSettingDataSource.h"
#import "ZCMacro.h"

static NSString * const mindeHomeCell = @"mindeSettingCell";

@interface ZCMineSettingViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *groups;

@end

@implementation ZCMineSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.groups = [ZCMineSettingDataSource dataSource];
    
    self.navigationItem.title = @"设置";
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[ZCMineHomeCell class] forCellReuseIdentifier:mindeHomeCell];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
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
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH-64) style:UITableViewStyleGrouped];
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
}


@end
