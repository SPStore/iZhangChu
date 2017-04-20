//
//  ZCRecommendViewController.m
//  掌厨
//
//  Created by Libo on 17/4/17.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecommendViewController.h"
#import "ZCMacro.h"
#import "ZCRecommendHeaderView.h"
#import "ZCRecommendBannerModel.h"

@interface ZCRecommendViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZCRecommendHeaderView *headerView;
@property (nonatomic, strong) NSArray *banners;
@end

@implementation ZCRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    
    
    self.tableView.tableHeaderView = self.headerView;
    
    
    [self resuestData];
}

- (void)resuestData {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary ];
    params[@"methodName"] = @"SceneHome";
    params[@"user_id"] = @"1513438";
    params[@"token"] = @"D2B34B72BBEE30ACDA4C4822781D823F";
    params[@"version"] = @4.92;
    
    [[SPHTTPSessionManager shareInstance] POST:@"http://api.izhangchu.com/?appVersion=4.91&sysVersion=10.2.1&devModel=iPhone" params:params success:^(id  _Nonnull responseObject) {
        self.banners = [ZCRecommendBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"banner"]];
        self.headerView.banners = self.banners;
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"x" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64) style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"x"];
    }
    return _tableView;
}

- (ZCRecommendHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[ZCRecommendHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 400)];
        
    }
    return _headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
