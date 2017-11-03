//
//  ZCRecommendViewController.m
//  掌厨
//
//  Created by Shengping on 17/4/17.
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

#import "ZCNavigationController.h"
#import "ZCRecipesSearchViewController.h"
#import "ZCCourseViewController.h"

#import "ZCWebViewController.h"
#import "ZCBasicIntroduceViewController.h"
#import "ZCIngredientsCollocationViewController.h"
#import "ZCSceneRecipesViewController.h"
#import "ZCFoodLiveViewController.h"

#import "ZCSceneInfoViewController.h"
#import "ZCDishedInfoViewController.h"
#import "ZCRecommendMasterViewController.h"
#import "ZCSelectedWorksViewController.h"

@interface ZCRecommendViewController () <UITableViewDelegate,UITableViewDataSource, SPCarouselViewDelegate,ZCRecomendCellDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZCRecommendHeaderView *headerView;
@property (nonatomic, strong) NSArray *banners;
@property (nonatomic, strong) NSMutableArray *sectionModels;
@end

@implementation ZCRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self requestData];
    
    [self registerCell];
}

- (void)setupTableView {
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;

    // 刷新
    // block方式
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    MJRefreshNormalHeader *header = (MJRefreshNormalHeader *)self.tableView.mj_header;
    header.stateLabel.alpha = header.arrowView.alpha = header.lastUpdatedTimeLabel.alpha = header.stateLabel.alpha = 0.6;
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:13];
    
    // 方法回调方式
    /*
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.stateLabel.alpha = header.arrowView.alpha = header.lastUpdatedTimeLabel.alpha = header.stateLabel.alpha = 0.6;
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:13];
    self.tableView.mj_header = header;
     */
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

- (void)requestData {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary ];
    params[@"methodName"] = @"SceneHome";
    params[@"user_id"] = @"0";
    params[@"token"] = @"0";
    params[@"version"] = @4.92;
    
    [MBProgressHUD showMessage:@"加载中..."];
    
    [[SPHTTPSessionManager shareInstance] POST:ZCHOSTURL params:params success:^(id  _Nonnull responseObject) {
        
        [MBProgressHUD hideHUD];
        
        self.headerView.searchBar.hidden = NO;
        
        // 头部轮播图数据
        self.banners = [ZCRecommendBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"banner"]];
        self.headerView.banners = self.banners;
        
        // cell数据
        NSArray *widgetLists = [ZCRecommendBasicModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"widgetList"]];
        
        NSMutableArray *modelArray1 = [NSMutableArray array];
        NSMutableArray *modelArray2 = [NSMutableArray array];
        NSMutableArray *modelArray3 = [NSMutableArray array];
        NSMutableArray *modelArray4 = [NSMutableArray array];
        NSMutableArray *modelArray5 = [NSMutableArray array];
        NSMutableArray *modelArray6 = [NSMutableArray array];
        NSMutableArray *modelArray7 = [NSMutableArray array];
        
        for (ZCRecommendBasicModel *basicModdel in widgetLists) {
            
            switch (basicModdel.widget_type) {
                case 1: {
                    // 这里是要把basicModdel的所有属性赋值给buttonModel,于是先把basicModdel转成字典，然后字典转模型
                    ZCRecommendButtonModel *buttonModel = [ZCRecommendButtonModel mj_objectWithKeyValues:basicModdel.mj_keyValues];
                    [modelArray1 addObject:buttonModel];
                }
                    break;
                case 2:
                {
                    ZCRecommendCanScrollModel *scrollModel = [ZCRecommendCanScrollModel mj_objectWithKeyValues:basicModdel.mj_keyValues];
                    [modelArray1 addObject:scrollModel];
                }
                    break;
                case 5:
                {
                    ZCRecommendVideoModel *videoModel = [ZCRecommendVideoModel mj_objectWithKeyValues:basicModdel.mj_keyValues];
                    [modelArray2 addObject:videoModel];
                }
                    break;
                case 3:
                {
                    ZCRecommendImageVideoModel *mageVideoModel = [ZCRecommendImageVideoModel mj_objectWithKeyValues:basicModdel.mj_keyValues];
                    [modelArray3 addObject:mageVideoModel];
                }
                    break;
                case 9:
                {
                    ZCRecommendEmptyModel *emptyModel = [ZCRecommendEmptyModel mj_objectWithKeyValues:basicModdel.mj_keyValues];
                    [modelArray4 addObject:emptyModel];
                }
                    break;
                case 4:
                {
                    ZCRecommendMasterListModel *listModel = [ZCRecommendMasterListModel mj_objectWithKeyValues:basicModdel.mj_keyValues];
                    [modelArray5 addObject:listModel];
                }
                    break;
                case 8:
                {
                    ZCRecommendHaveHeaderIconImageModel *iconImageModel = [ZCRecommendHaveHeaderIconImageModel mj_objectWithKeyValues:basicModdel.mj_keyValues];
                    [modelArray6 addObject:iconImageModel];
                }
                    break;
                case 7:
                {
                    ZCRecommendImageViewTitleModel *imgTitleModel = [ZCRecommendImageViewTitleModel mj_objectWithKeyValues:basicModdel.mj_keyValues];
                    [modelArray7 addObject:imgTitleModel];
                }
                    break;
                default:
                    break;
            }
        }
        
        self.sectionModels = @[modelArray1,modelArray2,modelArray3,modelArray4,modelArray5,modelArray6,modelArray7].mutableCopy;
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError * _Nonnull error) {
        ZCLog(@"%@",error);
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD hideHUD];
    }];
    
}

- (void)loadNewData {
    [self requestData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sectionModels[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *modelArray = self.sectionModels[indexPath.section];
    ZCRecommendBasicModel *basicModel = modelArray[indexPath.row];
    ZCRecommendBasicCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(basicModel.class) forIndexPath:indexPath];
    cell.model = basicModel;
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *modelArray = self.sectionModels[indexPath.section];
    ZCRecommendBasicModel *basicModel = modelArray[indexPath.row];
    return basicModel.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.0f;
    }
    return 10;
}

#pragma mark - 轮播图的代理方法
- (void)carouselView:(SPCarouselView *)carouselView clickedImageAtIndex:(NSUInteger)index {
    ZCRecommendBannerModel *banner = self.banners[index];
    if ([banner.banner_link hasPrefix:@"http"]) {
        ZCWebViewController *webVc = [[ZCWebViewController alloc] init];
        webVc.urlString = banner.banner_link;
        [self.navigationController pushViewController:webVc animated:YES];
    } else {
        ZCCourseViewController *courseVc = [[ZCCourseViewController alloc] init];

        // 网络请求的参数series_id藏在banner_link中
        NSArray *parts = [banner.banner_link componentsSeparatedByString:@"#"];
        if (parts.count > 1) {
            courseVc.series_id = parts[1];
        }
        [self.navigationController pushViewController:courseVc animated:YES];

    }
    
}

#pragma mark - textField的代理方法 

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    ZCRecipesSearchViewController *searchVc = [[ZCRecipesSearchViewController alloc] init];
    // 用一个导航控制器包装，因为在搜索控制器中需要push。当然也可以拿到其他导航控制器去push，比如跟控制器的第一个导航控制器，但是那样做，就无法pop回搜索控制器
    ZCNavigationController *navi = [[ZCNavigationController alloc] initWithRootViewController:searchVc];
    [self presentViewController:navi animated:YES completion:nil];
}

#pragma mark - cell的代理方法
- (void)recommendButtonOnButtonCellClickedWithButtonType:(ZCRecommendButtonCellButtonType)btnType {
    switch (btnType) {
            // 新手入门
        case ZCRecommendButtonCellButtonTypeBasicIntroduce:
        {
            
            ZCBasicIntroduceViewController *basicIntroduceVc = [[ZCBasicIntroduceViewController alloc] init];
            [self.navigationController pushViewController:basicIntroduceVc animated:YES];
        }
            
            break;
            // 食材搭配
        case ZCRecommendButtonCellButtonTypeIngredientsCollocation:
        {
            ZCIngredientsCollocationViewController *ingredientsCollocationVc = [[ZCIngredientsCollocationViewController alloc] init];
            [self.navigationController pushViewController:ingredientsCollocationVc animated:YES];
        }
            break;
            // 场景菜谱
        case ZCRecommendButtonCellButtonTypeSceneRecipes:
        {
            ZCSceneRecipesViewController *sceneRecipesVC = [[ZCSceneRecipesViewController alloc] init];
            [self.navigationController pushViewController:sceneRecipesVC animated:YES];
            
        }
            break;
            // 美食直播
        case ZCRecommendButtonCellButtonTypeFoodLive:
        {
            
            ZCFoodLiveViewController *foodLiveVc = [[ZCFoodLiveViewController alloc] init];
            [self.navigationController pushViewController:foodLiveVc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

// 含有横向滑动的scrollView的cell的代理方法
- (void)recommendCanScrollCellImageClickedWithItem:(ZCRecommendWidgetItem *)item {
    ZCWebViewController *webVc = [[ZCWebViewController alloc] init];
    webVc.urlString = item.link;
    [self.navigationController pushViewController:webVc animated:YES];
}

- (void)recommendTitleCellClickedWithModel:(ZCRecommendImageViewTitleModel *)model {
    if ([model.title containsString:@"全部场景"]) {
        ZCSceneRecipesViewController *sceneRecipesVc = [[ZCSceneRecipesViewController alloc] init];
        [self.navigationController pushViewController:sceneRecipesVc animated:YES];
    } else if([model.title containsString:@"推荐达人"]) {
        ZCRecommendMasterViewController *masterVc = [[ZCRecommendMasterViewController alloc] init];
        [self.navigationController pushViewController:masterVc animated:YES];
    } else if([model.title containsString:@"精选作品"]) {
        ZCSelectedWorksViewController *selectedWorksVc = [[ZCSelectedWorksViewController alloc] init];
        [self.navigationController pushViewController:selectedWorksVc animated:YES];
    } else {
        ZCSceneInfoViewController *sceneInfoVc = [[ZCSceneInfoViewController alloc] init];
        // 网络请求的参数series_id藏在title_link中
        NSArray *parts = [model.title_link componentsSeparatedByString:@"#"];
        if (parts.count > 1) {
            sceneInfoVc.scene_id = parts[1];
        }
        [self.navigationController pushViewController:sceneInfoVc animated:YES];
    }
}

- (void)recommendVideoCellVideoItemViewClicked:(ZCRecommendWidgetItem *)item {
    ZCDishedInfoViewController *dishInfoVc = [[ZCDishedInfoViewController alloc] init];
    NSArray *arr = [item.link componentsSeparatedByString:@"#"];
    if (arr.count > 1) {
       dishInfoVc.dishes_id = arr[1];
    }
    [self.navigationController pushViewController:dishInfoVc animated:YES];
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
        _tableView.sectionFooterHeight = CGFLOAT_MIN;
        _tableView.sectionHeaderHeight = CGFLOAT_MIN;

        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.tableFooterView = view;
    }
    return _tableView;
}

- (ZCRecommendHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[ZCRecommendHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kCarouselViewHeight+kSearchBarHeight+2*KSearchBarMargin_tb)];
        _headerView.backgroundColor = ZCBackgroundColor;
        _headerView.carouselView.delegate = self;
        _headerView.searchBar.delegate = self;
    }
    return _headerView;
}

- (NSMutableArray *)sectionModels {
    if (!_sectionModels) {
        _sectionModels = [NSMutableArray array];
    }
    return _sectionModels;
}

- (BOOL)shouldAutorotate {
    return YES;
}

// 支持的方向 因为界面A我们只需要支持竖屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
