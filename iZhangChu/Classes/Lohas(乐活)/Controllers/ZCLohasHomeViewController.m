//
//  ZCLohasHomeViewController.m
//  掌厨
//
//  Created by Shengping on 17/4/17.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCLohasHomeViewController.h"
#import "ZCLohasHomeCollectionViewCell.h"
#import "ZCLohasHomeTableViewCell.h"
#import "ZCLohasLogoModel.h"
#import "ZCLohasListModel.h"
#import "ZCCourseViewController.h"
#import "ZCLohasNagationView.h"

#define kCollectionViewH 80

@interface ZCLohasHomeViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UITableViewDataSource,UITableViewDelegate,SPPageMenuDelegate>

@property (nonatomic, strong) ZCLohasNagationView *myNagationView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITableView *tableView;

// 这张view是为了遮住下拉刷新的文字
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) NSArray *dataModelsForCollectionView;
@property (nonatomic, strong) NSArray *dataModelsForTableView;

@property (nonatomic, copy) NSString *methodName;
@property (nonatomic, copy) NSString *logoMethodName;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) NSInteger pageMultiplySize;
@property (nonatomic, assign) NSInteger total;

@end

@implementation ZCLohasHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.methodName = @"CourseIndex";
    self.logoMethodName = @"CourseLogo";
    self.page = 1;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationView = (ZCNavigationView *)self.myNagationView;
    
    [self.view addSubview:self.tableView];

    [self.view addSubview:self.collectionView];
    
    // 注册
    [self.collectionView registerClass:[ZCLohasHomeCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ZCLohasHomeCollectionViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCLohasHomeTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZCLohasHomeTableViewCell class])];
    // 请求collectionView的数据
    [self requestCollectionViewData];
    // 请求tableView的数据
    [self requestTableViewData];
    
    // 下拉刷新
    [self downPullUpdateData];
    // 上拉加载
    [self upPullLoadMoreData];
    
}

- (void)requestCollectionViewData {
    NSMutableDictionary *params = [NSMutableDictionary dictionary ];
    NSString *urlString;
    
    if (![self.methodName isEqualToString:@""]) {
        params[@"methodName"] = self.logoMethodName;
        urlString = ZCHOSTURL;
    } else {
        urlString = @"http://javaapi.izhangchu.com:8084/zcmessage/api/lifeCourseSeries/CourseLogo?";
    }
    params[@"user_id"] = @"0";
    params[@"token"] = @"0";
    params[@"version"] = @4.92;
    
    [[SPHTTPSessionManager shareInstance] POST:urlString params:params success:^(id  _Nonnull responseObject) {
        self.dataModelsForCollectionView = [ZCLohasLogoModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"albums"]];
        [self.collectionView reloadData];
    } failure:^(NSError * _Nonnull error) {
        ZCLog(@"%@",error);
    }];
    
}

- (void)requestTableViewData {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSString *urlString;
    
    if (![self.methodName isEqualToString:@""]) {
       params[@"methodName"] = self.methodName;
        urlString = ZCHOSTURL;
    } else {
        urlString = @"http://javaapi.izhangchu.com:8084/zcmessage/api/lifeCourseSeries/CourseIndex?";
    }
    params[@"page"] = @(self.page);
    params[@"size"] = @10;
    params[@"user_id"] = @"0";
    params[@"token"] = @"0";
    params[@"version"] = @4.92;
    
    [[SPHTTPSessionManager shareInstance] POST:urlString params:params success:^(id  _Nonnull responseObject) {
        ZCLohasListModel *listModel = [ZCLohasListModel mj_objectWithKeyValues:responseObject[@"data"]];
        // tableview数据源
        self.dataModelsForTableView = listModel.data;
        // 刷新tableView
        [self.tableView reloadData];
        
        // page * size
        self.pageMultiplySize = listModel.size * listModel.page;
        // 总个数
        self.total = listModel.total;
        
        if (self.pageMultiplySize >= self.total) {
            self.page--;
        }
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        ZCLog(@"%@",error);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

// 下拉刷新
- (void)downPullUpdateData {
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self requestTableViewData];
        [self requestCollectionViewData];
    }];
    MJRefreshNormalHeader *header = (MJRefreshNormalHeader *)self.tableView.mj_header;
    header.stateLabel.alpha = header.arrowView.alpha = header.lastUpdatedTimeLabel.alpha = header.stateLabel.alpha = 0.6;
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:13];
}

// 上拉加载更多
- (void)upPullLoadMoreData {
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self requestTableViewData];
        if (self.pageMultiplySize >= self.total) {
            [MBProgressHUD showMessageOnScreenBottom:@"没有更多数据了" hideAfterTime:0.5f];
        }
    }];
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataModelsForCollectionView.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCLohasHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZCLohasHomeCollectionViewCell class]) forIndexPath:indexPath];
    cell.model = self.dataModelsForCollectionView[indexPath.row];
    return cell;
}

#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCCourseViewController *courseVc = [[ZCCourseViewController alloc] init];
    if ([self.methodName isEqualToString:@""]) {
        courseVc.isJavaApi = YES;
    }
    ZCLohasLogoModel *logoModel = self.dataModelsForCollectionView[indexPath.row];
    courseVc.series_id = logoModel.series_id;
    [self.navigationController pushViewController:courseVc animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(60, 60);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 20, 0, 20);
}

#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataModelsForTableView.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZCLohasHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZCLohasHomeTableViewCell class]) forIndexPath:indexPath];
    cell.model = self.dataModelsForTableView[indexPath.row];
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCCourseViewController *courseVc = [[ZCCourseViewController alloc] init];
    if ([self.methodName isEqualToString:@""]) {
        courseVc.isJavaApi = YES;
    }
    ZCLohasListDataModel *dataModel = self.dataModelsForTableView[indexPath.row];
    courseVc.series_id = [NSString stringWithFormat:@"%zd",dataModel.series_id];
    [self.navigationController pushViewController:courseVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 270;
}

- (void)pageMenu:(SPPageMenu *)pageMenu buttonClickedAtIndex:(NSInteger)index {
    if (index == 0) {
        self.methodName = @"CourseIndex";
        self.logoMethodName = @"CourseLogo";
    } else if(index == 1) {
        self.methodName = @"";
        self.logoMethodName = @"";
    } else {
        self.methodName = @"TwCourseIndex";
        self.logoMethodName = @"TwCourseLogo";
    }
    [self requestTableViewData];
    [self requestCollectionViewData];
}

- (void)searchButtonAction:(UIButton *)sender {
    
}

- (ZCLohasNagationView *)myNagationView {
    
    if (!_myNagationView) {
        _myNagationView = [[ZCLohasNagationView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 64)];
        _myNagationView.pageMenu.delegate = self;
        [_myNagationView.searchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _myNagationView;
}


- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kCollectionViewH) collectionViewLayout:flowLayout];
        // 透明色
        _collectionView.backgroundColor = [UIColor clearColor];
        // 实现模糊效果,毛玻璃不能直接加在collectionView上，否则cell也会跟着被毛玻璃。也不能自给另外创建一张view然后插入collectionView的第一个子控件，那样会直接把cell给盖住
        UIBlurEffect *blurEffrct =[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        // 毛玻璃视图
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffrct];
        visualEffectView.frame = _collectionView.bounds;
        visualEffectView.alpha = 0.9;
        // backgroundView是一个nil值,需要自己创建,backgroundView在cell、headerView和footerView之后
        _collectionView.backgroundView = [[UIView alloc] initWithFrame:_collectionView.bounds];
        [_collectionView.backgroundView addSubview:visualEffectView];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    
    return _collectionView;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 64) style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(kCollectionViewH, 0, 49, 0);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, -kCollectionViewH , kScreenW, kCollectionViewH)];
        _topView.backgroundColor = [UIColor whiteColor];
        [_tableView addSubview:_topView];
    }
    return _tableView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        
        CGRect tFrame = self.topView.frame;
        if (-scrollView.contentOffset.y > kCollectionViewH) {  // tableView往下拉时,topView依然看起来位置不变
            tFrame.origin.y = scrollView.contentOffset.y;
        } else {
            tFrame.origin.y = -kCollectionViewH;
        }
        self.topView.frame = tFrame;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
