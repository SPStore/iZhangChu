//
//  ZCCourseViewController.m
//  iZhangChu
//
//  Created by Libo on 17/4/25.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCCourseViewController.h"
#import "ZCCourseHeaderView.h"
#import "ZCMacro.h"
#import "ZCCourseHeaderModel.h"

@interface ZCCourseViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) ZCCourseHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ZCCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    self.headerView = [ZCCourseHeaderView courseHeaderView];
    self.tableView.tableHeaderView = self.headerView;
    
    self.navigationView.title = self.banner.banner_title;
    
    [self requestData];
}

- (void)requestData {
    NSMutableDictionary *params = [NSMutableDictionary dictionary ];
    params[@"methodName"] = @"CourseSeriesView";
    params[@"series_id"] = [NSString stringWithFormat:@"%ld",(long)self.banner.banner_id];
    params[@"user_id"] = 0;
    params[@"token"] = 0;
    params[@"version"] = @4.92;
    
    [[SPHTTPSessionManager shareInstance] POST:ZCHOSTURL params:params success:^(id  _Nonnull responseObject) {
        ZCCourseHeaderModel *headerModel = [ZCCourseHeaderModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.headerView.headerModel = headerModel;
        

    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH-64) style:UITableViewStyleGrouped];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = ZCBackgroundColor;
        
    }
    return _tableView;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
