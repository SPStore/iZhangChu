//
//  ZCCourseViewController.m
//  iZhangChu
//
//  Created by Shengping on 17/4/25.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCCourseViewController.h"
#import "ZCMacro.h"
#import "ZCCourseHeaderView.h"
#import "ZCCourseRelateModel.h"
#import "ZCCourseHeaderModel.h"
#import "ZCCourseEpisodeModel.h"
#import "ZCCourseZanModel.h"
#import "ZCCourseCommentModel.h"

#import "ZCCourseCommentCell.h"

static NSString * const commentCellId = @"courseCommentCell";

@interface ZCCourseViewController () <UITableViewDataSource, UITableViewDelegate,ZCCourseHeaderViewDelegate>

@property (nonatomic, strong) ZCCourseHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *commentArray;
@property (nonatomic, assign) NSInteger page;
@end

@implementation ZCCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1; // 默认1
    
    [self.view addSubview:self.tableView];
    self.headerView = [ZCCourseHeaderView courseHeaderView];
    self.headerView.delegate = self;
    self.tableView.tableHeaderView = self.headerView;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCCourseCommentCell class]) bundle:nil] forCellReuseIdentifier:commentCellId];
    
    // 头部部分数据
    [self requestData:self.series_id];
    // 评论数据
    [self requestCommentData:self.series_id];
    
    // 上拉加载更多
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 加载更多评论
        [self loadMoreComment:self.series_id];
    }];
    self.tableView.mj_footer = footer;
}

// 头部部分数据
- (void)requestData:(NSString *)series_id {
    NSMutableDictionary *params = [NSMutableDictionary dictionary ];
    NSString *urlStrig;
    if (!self.isJavaApi) {
        params[@"methodName"] = @"CourseSeriesView";
        urlStrig = ZCHOSTURL;
    } else {
        urlStrig = @"http://javaapi.izhangchu.com:8084/zcmessage/api/lifeCourseSeries/CourseSeriesView?";
    }
    params[@"series_id"] = series_id;
    params[@"user_id"] = 0;
    params[@"token"] = 0;
    params[@"version"] = @4.92;
    
    [[SPHTTPSessionManager shareInstance] POST:urlStrig params:params success:^(id  _Nonnull responseObject) {
        ZCCourseHeaderModel *headerModel = [ZCCourseHeaderModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.headerView.headerModel = headerModel;
        
        NSArray *parts = [headerModel.series_name componentsSeparatedByString:@"#"];
        if (parts.count > 1) {
            self.navigationItem.title = parts[1];
        }
        // 头部数据不需要刷新tableView
        
    } failure:^(NSError * _Nonnull error) {
        ZCLog(@"error = %@",error);
    }];
}

// 相关课程数据
- (void)requestCourseRelateData:(NSString *)course_id {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSString *urlStrig;

    if (!self.isJavaApi) {
        params[@"methodName"] = @"CourseRelate";
        urlStrig = ZCHOSTURL;
    } else {
        urlStrig = @"http://javaapi.izhangchu.com:8084/zcmessage/api/lifeCourseSeries/CourseRelate?";
    }
    params[@"course_id"] = course_id;
    params[@"page"] = @1;
    params[@"size"] = @10;
    params[@"user_id"] = 0;
    params[@"token"] = 0;
    params[@"version"] = @4.92;
    
    [[SPHTTPSessionManager shareInstance] POST:urlStrig params:params success:^(id  _Nonnull responseObject) {
        ZCCourseRelateModel *courseRelateModel = [ZCCourseRelateModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.headerView.courseRelateModel = courseRelateModel;
        // 头部数据不需要刷新tableView
        
    } failure:^(NSError * _Nonnull error) {
        ZCLog(@"error = %@",error);
    }];
}

// 点赞列表数据
- (void)requestDianzanListData:(NSString *)post_id {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSString *urlStrig;
    
    if (!self.isJavaApi) {
        params[@"methodName"] = @"DianzanList";
        urlStrig = ZCHOSTURL;
    } else {
        urlStrig = @"http://javaapi.izhangchu.com:8084/zcmessage/api/lifeCourseSeries/DianzanList?";
    }
    params[@"post_id"] = post_id;
    params[@"page"] = @1;
    params[@"size"] = @7;
    params[@"user_id"] = 0;
    params[@"token"] = 0;
    params[@"version"] = @4.92;
    
    [[SPHTTPSessionManager shareInstance] POST:urlStrig params:params success:^(id  _Nonnull responseObject) {
        ZCCourseZanModel *zanModel = [ZCCourseZanModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.headerView.zanModel = zanModel;
        // 头部数据不需要刷新tableView
        
    } failure:^(NSError * _Nonnull error) {
        ZCLog(@"error = %@",error);
    }];
}

// 评论数据
- (void)requestCommentData:(NSString *)relate_id {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSString *urlStrig;
    
    if (!self.isJavaApi) {
        params[@"methodName"] = @"CommentList";
        urlStrig = ZCHOSTURL;
    } else {
        urlStrig = @"http://javaapi.izhangchu.com:8084/zcmessage/api/lifeCourseSeries/CommentList?";
    }
    params[@"relate_id"] = relate_id;
    params[@"page"] = @(_page);
    params[@"size"] = @(10);
    params[@"user_id"] = @0;
    params[@"token"] = @0;
    params[@"type"] = @2;
    params[@"version"] = @4.92;
    [[SPHTTPSessionManager shareInstance] POST:urlStrig params:params success:^(id  _Nonnull responseObject) {
        
        ZCCourseCommentModel *commentModel = [ZCCourseCommentModel mj_objectWithKeyValues:responseObject[@"data"]];
        if (commentModel.count <= 0) {
            [self.tableView.mj_footer endRefreshing];
            return;
        } else {
            self.headerView.commentCount += commentModel.count;
            // 获得评论数组
            [self.commentArray addObjectsFromArray:commentModel.data];
            
        }
        // 刷新tableView
        [self.tableView reloadData];
        // 不能调endRefreshingWithNoMoreData,否则即便有更多数据也不会再去加载
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSError * _Nonnull error) {
        ZCLog(@"error = %@",error);
        [self.tableView.mj_footer endRefreshing];
    }];
}

// 加载更多评论
- (void)loadMoreComment:(NSString *)relate_id {
    self.page++;
    [self requestCommentData:relate_id];
    
}

#pragma mark - ZCCourseHeaderView的代理方法
// 每集按钮被点击
- (void)headerViewEpisodeButtonClicked:(ZCCourseEpisodeButton *)episodeButton {
    [self requestCourseRelateData:[NSString stringWithFormat:@"%ld",(long)episodeButton.episodeModel.course_id]];
    
    [self requestDianzanListData:[NSString stringWithFormat:@"%ld",(long)episodeButton.episodeModel.course_id]];
    
}

// 更新至第几集的按钮被点击
- (void)headerViewUpdateFoldingButtonClicked:(SPButton *)sender {
    self.tableView.tableHeaderView = self.headerView;
}

#pragma mark - tableView的代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZCCourseCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCellId forIndexPath:indexPath];
    cell.comment = self.commentArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark - lazy

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH-64) style:UITableViewStyleGrouped];
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

- (NSMutableArray *)commentArray {
    
    if (!_commentArray) {
        _commentArray = [NSMutableArray array];
        
    }
    return _commentArray;
}


- (void)dealloc {
    ZCLog(@"%s",__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
