//
//  ZCSceneInfoViewController.m
//  iZhangChu
//
//  Created by Shengping on 17/5/11.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCSceneInfoViewController.h"
#import "ZCSceneInfoListCell.h"
#import "ZCSceneInfoHeaderView.h"
#import "ZCSceneInfoDataModel.h"
#import "ZCSceneInfoListModel.h"
#import "ZCNavigationController.h"
#import "ZCRecipesSearchViewController.h"
#import "ZCMacro.h"

#define kHeaderViewH 200

static NSString * const sceneInfoListCellID = @"sceneInfoListCell";

@interface ZCSceneInfoViewController () <UITableViewDataSource,UITableViewDelegate>
// 表头
@property (nonatomic, strong) ZCSceneInfoHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) UIButton *searchButton;
@property (nonatomic, weak) UIButton *shareButton;


@property (nonatomic, strong) NSArray *listModelArray;

@end

@implementation ZCSceneInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    [self setupNavi];

    // 如果要实现表头下拉放大，self.headerView不可以赋值给tableView的tableHeaderView
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kHeaderViewH)];
    [headerView addSubview:self.headerView];
    self.tableView.tableHeaderView = headerView;
    
    [self.tableView registerClass:[ZCSceneInfoListCell class] forCellReuseIdentifier:sceneInfoListCellID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCSceneInfoListCell class]) bundle:nil] forCellReuseIdentifier:sceneInfoListCellID];
    [self requestData];

}

- (void)setupNavi {
    // 导航栏的标题颜色
    self.navTitleColor = [UIColor whiteColor];
    // 导航栏上的item的颜色，包括item的图片和文字
    self.navTintColor = [UIColor whiteColor];
    // 导航栏的背景颜色
    self.navBarTintColor = [UIColor whiteColor];
    // 导航栏的背景alpha
    self.navAlpha = 0;
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(kScreenW-70, 0, 54, 44)];
    
    CGFloat searchButtonW = 22;
    CGFloat searchButtonH = searchButtonW;
    UIButton *searchButton = [[UIButton alloc] init];
    self.searchButton = searchButton;
    searchButton.frame = CGRectMake(0, 11, searchButtonW, 30);
    [searchButton setImage:[UIImage imageNamed:@"searchWhite"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:searchButton];
    
    UIButton *shareButton = [[UIButton alloc] init];
    self.shareButton = shareButton;
    shareButton.frame = CGRectMake(32, 11, searchButtonW, searchButtonH);
    [shareButton setImage:[UIImage imageNamed:@"ico_share_white"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:shareButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];

}

- (void)requestData {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary ];
    params[@"methodName"] = @"SceneInfo";
    params[@"scene_id"] = self.scene_id;
    params[@"user_id"] = @"0";
    params[@"token"] = @"0";
    params[@"version"] = @4.92;
    
    [MBProgressHUD showMessage:@"加载中..."];
    
    [[SPHTTPSessionManager shareInstance] POST:ZCHOSTURL params:params success:^(id  _Nonnull responseObject) {
        
        [MBProgressHUD hideHUD];
        
        ZCSceneInfoDataModel *dataModel = [ZCSceneInfoDataModel mj_objectWithKeyValues:responseObject[@"data"]];
        // 导航栏标题
        self.navigationItem.title = dataModel.scene_title;
        // 给表头传递模型
        self.headerView.model = dataModel;
        // cell的列表模型数组
        self.listModelArray = dataModel.dishes_list;
        // 刷新tableView
        [self.tableView reloadData];
        
    } failure:^(NSError * _Nonnull error) {
        ZCLog(@"%@",error);
        [MBProgressHUD hideHUD];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCSceneInfoListModel *listModel = self.listModelArray[indexPath.row];
    ZCSceneInfoListCell *cell = [tableView dequeueReusableCellWithIdentifier:sceneInfoListCellID forIndexPath:indexPath];
    cell.model = listModel;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 115;
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (scrollView == self.tableView) {
        // 改变导航栏及其子控件的颜色或图片
        [self changeColorWithOffsetY:offsetY];
        // 下拉放大
        [self pullDownEnlargeWithOffsetY:offsetY];
        
        [self changeStatusBarColor];
    }
}

- (void)pullDownEnlargeWithOffsetY:(CGFloat)offsetY {
    if(offsetY < 0) {
        CGFloat totalOffset = kHeaderViewH + ABS(offsetY);
        CGFloat f = totalOffset / kHeaderViewH;
        // 拉伸后的图片的frame应该是同比例缩放。
        self.headerView.frame = CGRectMake(-(kScreenW*f-kScreenW) / 2, offsetY, kScreenW*f, totalOffset);
    }
}

- (void)changeColorWithOffsetY:(CGFloat)offsetY {
    // 滑出20偏移时开始发生渐变,(kHeaderViewH - 20 - 64)决定渐变时间长度
    
    if (offsetY >= 20) {
       CGFloat alpha = (offsetY-20)/(kHeaderViewH-20-64);
        // 该属性是设置导航栏背景渐变
        self.navAlpha = alpha;

        [self.searchButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        [self.shareButton setImage:[UIImage imageNamed:@"ico_share_black_p_22x22_"] forState:UIControlStateNormal];
        self.navTintColor = [UIColor grayColor];

        self.navTitleColor = [UIColor colorWithWhite:1-alpha alpha:1];

    } else {
        self.navAlpha = 0;
        [self.searchButton setImage:[UIImage imageNamed:@"searchWhite"] forState:UIControlStateNormal];
        [self.shareButton setImage:[UIImage imageNamed:@"ico_share_white"] forState:UIControlStateNormal];
        
        self.navTintColor = [UIColor whiteColor];
        self.navTitleColor = [UIColor whiteColor];
    }

}

// 要系统自动调用这个方法，要在导航控制器中实现-(UIViewController *)childViewControllerForStatusBarStyle方法
- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.tableView.contentOffset.y > (kHeaderViewH-20-64)) {
        return UIStatusBarStyleDefault;
    } else {
        return UIStatusBarStyleLightContent;
    }
}


- (void)changeStatusBarColor {
    // 调用preferredStatusBarStyle改变状态栏的颜色
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark 导航栏上的三个按钮点击方法
- (void)share {
    
}

- (void)search {
    ZCRecipesSearchViewController *searchVc = [[ZCRecipesSearchViewController alloc] init];
    // 用一个导航控制器包装，因为在搜索控制器中需要push。当然也可以拿到其他导航控制器去push，比如跟控制器的第一个导航控制器，但是那样做，就无法pop回搜索控制器
    ZCNavigationController *navi = [[ZCNavigationController alloc] initWithRootViewController:searchVc];
    [self presentViewController:navi animated:YES completion:nil];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (ZCSceneInfoHeaderView *)headerView {
    
    if (!_headerView) {
        _headerView = [ZCSceneInfoHeaderView shareSceneInfoHeaderView];
        _headerView.frame = CGRectMake(0, 0, kScreenW, kHeaderViewH);
    }
    return _headerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = ZCBackgroundColor;
    }
    return _tableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
