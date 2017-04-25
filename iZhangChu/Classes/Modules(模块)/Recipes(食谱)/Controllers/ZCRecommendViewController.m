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
#import "ZCRecommendButtonModel.h"
#import "ZCRecommendCanScrollModel.h"
#import "ZCRecommendVideoModel.h"
#import "ZCRecommendImageVideoModel.h"
#import "ZCRecommendEmptyModel.h"
#import "ZCRecommendMasterListModel.h"
#import "ZCRecommendHaveHeaderIconImageModel.h"
#import "ZCRecommendImageViewTitleModel.h"
#import "ZCRecommendBasicCell.h"

#import "ZCCourseViewController.h"

@interface ZCRecommendViewController () <UITableViewDelegate,UITableViewDataSource, SPCarouseScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZCRecommendHeaderView *headerView;
@property (nonatomic, strong) NSArray *banners;
@property (nonatomic, strong) NSMutableArray *sectionModels;
@end

@implementation ZCRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self resuestData];
    
    [self registerCell];
}

- (void)setupTableView {
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
}

- (void)registerCell {
  
    // 存放所有model类名
    NSArray *modelClassNames = @[@"ZCRecommendButtonModel",@"ZCRecommendCanScrollModel",@"ZCRecommendVideoModel",@"ZCRecommendImageVideoModel",@"ZCRecommendEmptyModel",@"ZCRecommendMasterListModel",@"ZCRecommendHaveHeaderIconImageModel",@"ZCRecommendImageViewTitleModel"];
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
    
    [[SPHTTPSessionManager shareInstance] POST:ZCHOSTURL params:params success:^(id  _Nonnull responseObject) {
        
        // 头部轮播图数据
        self.banners = [ZCRecommendBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"banner"]];
        self.headerView.banners = self.banners;
        
        // cell数据
        NSArray *widgetLists = [ZCRecommendBasicModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"widgetList"]];
        for (ZCRecommendBasicModel *basicModdel in widgetLists) {
            
            switch (basicModdel.widget_type) {
                case 1: {
                    ZCRecommendButtonModel *buttonModel = [ZCRecommendButtonModel mj_objectWithKeyValues:basicModdel.mj_keyValues];
                    [self.sectionModels addObject:buttonModel];
                }
                    break;
                case 2:
                {
                    ZCRecommendCanScrollModel *scrollModel = [ZCRecommendCanScrollModel mj_objectWithKeyValues:basicModdel.mj_keyValues];
                    [self.sectionModels addObject:scrollModel];
                }
                    break;
                case 5:
                {
                    ZCRecommendVideoModel *videoModel = [ZCRecommendVideoModel mj_objectWithKeyValues:basicModdel.mj_keyValues];
                    [self.sectionModels addObject:videoModel];
                }
                    break;
                case 3:
                {
                    ZCRecommendImageVideoModel *mageVideoModel = [ZCRecommendImageVideoModel mj_objectWithKeyValues:basicModdel.mj_keyValues];
                    [self.sectionModels addObject:mageVideoModel];
                }
                    break;
                case 9:
                {
                    ZCRecommendEmptyModel *emptyModel = [ZCRecommendEmptyModel mj_objectWithKeyValues:basicModdel.mj_keyValues];
                    [self.sectionModels addObject:emptyModel];
                }
                    break;
                case 4:
                {
                    ZCRecommendMasterListModel *listModel = [ZCRecommendMasterListModel mj_objectWithKeyValues:basicModdel.mj_keyValues];
                    [self.sectionModels addObject:listModel];
                }
                    break;
                case 8:
                {
                    ZCRecommendHaveHeaderIconImageModel *iconImageModel = [ZCRecommendHaveHeaderIconImageModel mj_objectWithKeyValues:basicModdel.mj_keyValues];
                    [self.sectionModels addObject:iconImageModel];
                }
                    break;
                case 7:
                {
                    ZCRecommendImageViewTitleModel *imgTitleModel = [ZCRecommendImageViewTitleModel mj_objectWithKeyValues:basicModdel.mj_keyValues];
                    [self.sectionModels addObject:imgTitleModel];
                }
                    break;
                default:
                    break;
            }
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
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
    ZCRecommendBasicModel *basicModel = self.sectionModels[indexPath.section];
    return basicModel.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 0.0f;
    }
    return 10;
}

#pragma mark - 轮播图的代理方法
- (void)carouseScrollView:(SPCarouselScrollView *)carouseScrollView atIndex:(NSUInteger)index {
    ZCRecommendBannerModel *banner = self.banners[index];
    ZCCourseViewController *courseVc = [[ZCCourseViewController alloc] init];
    courseVc.banner = banner;
    [self.navigationController pushViewController:courseVc animated:YES];
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64) style:UITableViewStyleGrouped];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = ZCBackgroundColor;
        _tableView.sectionFooterHeight = 0.0f;
        _tableView.sectionHeaderHeight = 0.0f;
    }
    return _tableView;
}

- (ZCRecommendHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[ZCRecommendHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kCarouselViewHeight+kSearchBarHeight+2*KSearchBarMargin_tb)];
        _headerView.backgroundColor = ZCBackgroundColor;
        _headerView.carouselScrollView.delegate = self;
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
