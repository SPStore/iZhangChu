//
//  ZCRecipesSearchResultViewController.m
//  iZhangChu
//
//  Created by Shengping on 17/4/29.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecipesSearchResultViewController.h"
#import "ZCMacro.h"
#import "ZCRecipesSearchResultModel.h"
#import "ZCRecipesAutoSearchModel.h"
#import "ZCRecipesSearchResultCell.h"
#import "ZCRecipesAutoSearchTopListCell.h"
#import "SaveSearchTextTool.h"

static NSString * const recipesSearchResultCellID = @"recipesSearchResultCell";

@interface ZCRecipesSearchResultViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ZCRecipesSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.navigationController.navigationBar.hidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"为你找到";
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCRecipesSearchResultCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZCRecipesSearchResultModel class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCRecipesAutoSearchTopListCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ZCRecipesAutoSearchTopListModel class])];
    
    if (self.dishes) { // 如果数组不是nil，则说明是点击上一个页面的第一个cell而来
        
        
    } else {
        [self requestData];
    }
    
}

- (void)requestData {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"methodName"] = @"SearchDishes";
    params[@"keyword"] = self.keyword;
    params[@"page"] = @1;
    params[@"size"] = @10;
    params[@"user_id"] = @"0";
    params[@"token"] = @"0";
    params[@"version"] = @4.92;
    
    [[SPHTTPSessionManager shareInstance] POST:ZCHOSTURL params:params success:^(id  _Nonnull responseObject) {
        
        self.dishes = [ZCRecipesSearchResultModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        // 将文字保存到沙盒
        [SaveSearchTextTool saveRecentSearchText:self.keyword];
        [self.tableView reloadData];
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dishes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSObject *dish = self.dishes[indexPath.row];
    
    ZCRecipesSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(dish.class) forIndexPath:indexPath];
    cell.keyword = self.keyword;
    cell.model = dish;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH-64) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = ZCBackgroundColor;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
