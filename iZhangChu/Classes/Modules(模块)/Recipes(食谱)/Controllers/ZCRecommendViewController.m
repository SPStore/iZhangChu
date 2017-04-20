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

#import "ZCRecommendBasicModel.h"
#import "ZCRecommendLikeModel.h"
#import "ZCRecommendLuckyMoneyEnterModel.h"
#import "ZCRecommendNewProductModel.h"
#import "ZCRecommendBasicCell.h"

@interface ZCRecommendViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZCRecommendHeaderView *headerView;
@property (nonatomic, strong) NSArray *banners;
@property (nonatomic, strong) NSMutableArray *sectionModels;
@end

@implementation ZCRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = self.headerView;
    
    
    [self resuestData];
    
    [self registerCell];
}

- (void)registerCell {
  
    // 存放所有model类名
    NSArray *modelClassNames = @[@"ZCRecommendLikeModel",@"ZCRecommendLuckyMoneyEnterModel",@"ZCRecommendNewProductModel"];
    for (NSString *modelClassName in modelClassNames) {
        // 由model类名获取cell类名
        NSString *cellClassName = [modelClassName stringByReplacingOccurrencesOfString:@"Model" withString:@"Cell"];
        // 根据model类名注册cell
        [self.tableView registerClass:NSClassFromString(cellClassName) forCellReuseIdentifier:modelClassName];
    }
}

- (void)resuestData {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary ];
    params[@"methodName"] = @"SceneHome";
    params[@"user_id"] = @"1513438";
    params[@"token"] = @"D2B34B72BBEE30ACDA4C4822781D823F";
    params[@"version"] = @4.92;
    
    [[SPHTTPSessionManager shareInstance] POST:@"http://api.izhangchu.com/?appVersion=4.91&sysVersion=10.2.1&devModel=iPhone" params:params success:^(id  _Nonnull responseObject) {
        
        // 头部轮播图数据
        self.banners = [ZCRecommendBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"banner"]];
        self.headerView.banners = self.banners;
        
        // cell数据
        NSArray *widgetLists = [ZCRecommendBasicModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"widgetList"]];
        for (ZCRecommendBasicModel *basicModdel in widgetLists) {
            
            switch (basicModdel.widget_type) {
                case 1: {
                    ZCRecommendLikeModel *likeModel = [[ZCRecommendLikeModel alloc] init];
                    likeModel.widget_data = basicModdel.widget_data;
                    [self.sectionModels addObject:likeModel];
                }
                    break;
                case 2:
                {
                    ZCRecommendLuckyMoneyEnterModel *luckyMoneyEnterModel = [[ZCRecommendLuckyMoneyEnterModel alloc] init];
                    luckyMoneyEnterModel.widget_data = basicModdel.widget_data;
                    [self.sectionModels addObject:luckyMoneyEnterModel];
                }
                    break;
                case 3:
                {
                    ZCRecommendNewProductModel *newProductModel = [[ZCRecommendNewProductModel alloc] init];
                    newProductModel.widget_data = basicModdel.widget_data;
                    [self.sectionModels addObject:newProductModel];
                }
                    break;
                default:
                    break;
            }
        }
        
        
        [self.tableView reloadData];
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCRecommendBasicModel *basicModel = self.sectionModels[indexPath.section];
    ZCRecommendBasicCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(basicModel.class) forIndexPath:indexPath];
    cell.model = basicModel;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
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
        _headerView = [[ZCRecommendHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 200)];
        
    }
    return _headerView;
}

- (NSMutableArray *)sectionModels {
    if (!_sectionModels) {
        _sectionModels = [NSMutableArray array];
    }
    return _sectionModels;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
