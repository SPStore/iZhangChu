//
//  ZCCourseViewController.m
//  iZhangChu
//
//  Created by Libo on 17/4/25.
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
@property (nonatomic, strong) NSArray *commentArray;
@end

@implementation ZCCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    self.headerView = [ZCCourseHeaderView courseHeaderView];
    self.headerView.delegate = self;
    self.tableView.tableHeaderView = self.headerView;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCCourseCommentCell class]) bundle:nil] forCellReuseIdentifier:commentCellId];
    
    // 网络请求的参数series_id藏在banner_link中
    NSArray *parts = [self.banner.banner_link componentsSeparatedByString:@"#"];
    if (parts.count > 1) {
        [self requestData:parts[1]];
        [self requestCommentData:parts[1]];
    }
    
}

// 头部部分数据
- (void)requestData:(NSString *)series_id {
    NSMutableDictionary *params = [NSMutableDictionary dictionary ];
    params[@"methodName"] = @"CourseSeriesView";
    params[@"series_id"] = series_id;
    params[@"user_id"] = 0;
    params[@"token"] = 0;
    params[@"version"] = @4.92;
    
    [[SPHTTPSessionManager shareInstance] POST:ZCHOSTURL params:params success:^(id  _Nonnull responseObject) {
        ZCCourseHeaderModel *headerModel = [ZCCourseHeaderModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.headerView.headerModel = headerModel;
        
        NSArray *parts = [headerModel.series_name componentsSeparatedByString:@"#"];
        if (parts.count > 1) {
            self.navigationView.title = parts[1];
        }
        // 头部数据不需要刷新tableView
        
    } failure:^(NSError * _Nonnull error) {
        ZCLog(@"error = %@",error);
    }];
}

// 相关课程数据
- (void)requestCourseRelateData:(NSString *)course_id {
    NSMutableDictionary *params = [NSMutableDictionary dictionary ];
    params[@"methodName"] = @"CourseRelate";
    params[@"course_id"] = course_id;
    params[@"page"] = @1;
    params[@"size"] = @10;
    params[@"user_id"] = 0;
    params[@"token"] = 0;
    params[@"version"] = @4.92;
    
    [[SPHTTPSessionManager shareInstance] POST:ZCHOSTURL params:params success:^(id  _Nonnull responseObject) {
        ZCCourseRelateModel *courseRelateModel = [ZCCourseRelateModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.headerView.courseRelateModel = courseRelateModel;
        // 头部数据不需要刷新tableView
        
    } failure:^(NSError * _Nonnull error) {
        ZCLog(@"error = %@",error);
    }];
}

// 点赞列表数据
- (void)requestDianzanListData:(NSString *)post_id {
    NSMutableDictionary *params = [NSMutableDictionary dictionary ];
    params[@"methodName"] = @"DianzanList";
    params[@"post_id"] = post_id;
    params[@"page"] = @1;
    params[@"size"] = @7;
    params[@"user_id"] = 0;
    params[@"token"] = 0;
    params[@"version"] = @4.92;
    
    [[SPHTTPSessionManager shareInstance] POST:ZCHOSTURL params:params success:^(id  _Nonnull responseObject) {
        ZCLog(@"---%@",responseObject);
        ZCCourseZanModel *zanModel = [ZCCourseZanModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.headerView.zanModel = zanModel;
        // 头部数据不需要刷新tableView
        
    } failure:^(NSError * _Nonnull error) {
        ZCLog(@"error = %@",error);
    }];
}

- (void)requestCommentData:(NSString *)relate_id {
    NSMutableDictionary *params = [NSMutableDictionary dictionary ];
    params[@"methodName"] = @"CommentList";
    params[@"relate_id"] = relate_id;
    params[@"page"] = @1;
    params[@"size"] = @7;
    params[@"user_id"] = @0;
    params[@"token"] = @0;
    params[@"type"] = @2;
    params[@"version"] = @4.92;
    [[SPHTTPSessionManager shareInstance] POST:ZCHOSTURL params:params success:^(id  _Nonnull responseObject) {
        
        ZCCourseCommentModel *commentModel = [ZCCourseCommentModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.headerView.commentCount = commentModel.count;
        // 获得评论数组
        self.commentArray = commentModel.data;
        
        // 刷新tableView
        [self.tableView reloadData];
        
    } failure:^(NSError * _Nonnull error) {
        ZCLog(@"error = %@",error);
    }];
}

#pragma mark - ZCCourseHeaderView的代理方法
// 每集按钮被点击
- (void)headerViewEpisodeButtonClicked:(ZCCourseEpisodeButton *)episodeButton {
    [self requestCourseRelateData:[NSString stringWithFormat:@"%ld",episodeButton.episodeModel.course_id]];
    
    [self requestDianzanListData:[NSString stringWithFormat:@"%ld",episodeButton.episodeModel.course_id]];
    
}

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

- (void)dealloc {
    ZCLog(@"%s",__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
