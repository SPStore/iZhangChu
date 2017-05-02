//
//  ZCRecipesSearchViewController.m
//  iZhangChu
//
//  Created by Libo on 17/4/28.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecipesSearchViewController.h"
#import "ZCMacro.h"
#import <MJExtension.h>
#import "ZCRecipesSearchGroup.h"
#import "ZCRecipesAutoSearchModel.h"
#import "ZCRecipesSearchCell.h"
#import "ZCRecipesAutoSearchCell.h"
#import "ZCSearchView.h"
#import "ZCRecipesSearchResultViewController.h"
#import "SaveSearchTextTool.h"

static NSString * const recipesSearchCellID = @"recipesSearchCell";

@interface ZCRecipesSearchViewController () <UITableViewDataSource, UITableViewDelegate,ZCSearchViewDelegate>
@property (nonatomic, strong) ZCSearchView *searchView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *topModelArray;
@property (nonatomic, strong) ZCRecipesSearchGroup *group;
@property (nonatomic, strong) NSMutableDictionary *lastDic;
@end

@implementation ZCRecipesSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[ZCRecipesSearchCell class] forCellReuseIdentifier:NSStringFromClass([ZCRecipesSearchGroup class])];
    [self.tableView registerClass:[ZCRecipesAutoSearchCell class] forCellReuseIdentifier:NSStringFromClass([ZCRecipesAutoSearchModel class])];
    
    
    [self requestHotSearchData];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getDataFromSandBox];
}

// 从沙盒中取出数据
- (void)getDataFromSandBox {
    
    [self.dataArray removeAllObjects];
    
    NSArray *textArray = [SaveSearchTextTool fectchSaveTextArray];
    if (textArray.count != 0) {
        ZCRecipesSearchGroup *group = [[ZCRecipesSearchGroup alloc] init];
        group.title = @"历史记录";
        for (int i = 0; i < textArray.count; i++) {
            ZCRecipesSearchModel *model = [[ZCRecipesSearchModel alloc] init];
            model.id = 0;
            model.text = textArray[i];
            [group.searchArray addObject:model];
        }
        [self.dataArray addObject:group];
    }
}

- (void)requestHotSearchData {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary ];
    params[@"methodName"] = @"SearchHot";
    params[@"user_id"] = @"0";
    params[@"token"] = @"0";
    params[@"version"] = @4.92;
    
    [[SPHTTPSessionManager shareInstance] POST:ZCHOSTURL params:params success:^(id  _Nonnull responseObject) {

        ZCRecipesSearchGroup *group = [[ZCRecipesSearchGroup alloc] init];
        group.title = @"热门搜索";
        // 不能直接赋值数组
        [group.searchArray addObjectsFromArray:[ZCRecipesSearchModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]]];
        [self.dataArray addObject:group];

        [self.tableView reloadData];
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"eror = %@",error);
    }];
}

- (void)requestAutoSearchData:(NSString *)keyword {
    
    [self.dataArray removeAllObjects];

    if (self.searchView.textField.text.length) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary ];
        params[@"methodName"] = @"SearchKeyword";
        params[@"keyword"] = self.searchView.textField.text;
        params[@"user_id"] = @"0";
        params[@"token"] = @"0";
        params[@"version"] = @4.92;
        
        self.lastDic = params;
        
        [[SPHTTPSessionManager shareInstance] POST:ZCHOSTURL params:params success:^(id  _Nonnull responseObject) {
            
            if (params == self.lastDic) {
          
                ZCRecipesAutoSearchModel *autoModel = [ZCRecipesAutoSearchModel mj_objectWithKeyValues:responseObject[@"data"][@"top"]];
                [self.dataArray addObject:autoModel];
                
                NSArray *dataArray = responseObject[@"data"][@"data"];
                [self.dataArray addObjectsFromArray: [ZCRecipesAutoSearchModel mj_objectArrayWithKeyValuesArray:dataArray]];
                [self.tableView reloadData];
            }
            
        } failure:^(NSError * _Nonnull error) {
            
        }];
    } else {
        [self getDataFromSandBox];
        [self requestHotSearchData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject *group = self.dataArray[indexPath.section];
    
    ZCRecipesSearchBasicCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([group class]) forIndexPath:indexPath];

    cell.indexPath = indexPath;
    cell.keyword = self.searchView.textField.text;
    cell.group = group;
    
    if ([cell isKindOfClass:[ZCRecipesSearchCell class]]) {
        ZCRecipesSearchCell *searchCell = (ZCRecipesSearchCell *)cell;
        // cell上的按钮被点击block回调
        searchCell.buttonClickedOnCellBlock = ^(ZCRecipesSearchButton *button) {
            
            [self.view endEditing:YES];
            
            self.searchView.textField.text = button.searchModel.text;
            [self searchViewKeyboardSearchButtonClicked:self.searchView.textField.text];
        };
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.view endEditing:YES];
    
    ZCRecipesSearchBasicCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell isKindOfClass:[ZCRecipesSearchCell class]]) {
        return;
    }
    
    if (indexPath.section == 0) {
        
        
    } else {
        ZCRecipesAutoSearchCell *autoCell = (ZCRecipesAutoSearchCell *)cell;
        ZCRecipesAutoSearchModel *autoModel = (ZCRecipesAutoSearchModel *)autoCell.group;
        self.searchView.textField.text = autoModel.text;
        [self searchViewKeyboardSearchButtonClicked:self.searchView.textField.text];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject *group = self.dataArray[indexPath.section];
    if ([group isKindOfClass:[ZCRecipesSearchGroup class]]) {
        ZCRecipesSearchGroup *searchGroup = (ZCRecipesSearchGroup *)group;
        return searchGroup.cellHeight;
    }
    return 44;
}

#pragma mark - ZCSearchViewDelegate
// 取消
- (void)searchViewCancelButtonClicked {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 文字发生变化
- (void)searchViewTextFieldDidChanged:(UITextField *)textField {
    [self requestAutoSearchData:textField.text];
}

// 键盘回车键
- (void)searchViewKeyboardSearchButtonClicked:(NSString *)string {
    [self.view endEditing:YES];

    ZCRecipesSearchResultViewController *searchResultVc = [[ZCRecipesSearchResultViewController alloc] init];
    searchResultVc.keyword = string;

    [self.navigationController pushViewController:searchResultVc animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (ZCSearchView *)searchView {
    
    if (!_searchView) {
        _searchView = [ZCSearchView searchView];
        _searchView.frame = CGRectMake(0, 0, kScreenW, 64);
        _searchView.delegate = self;
        _searchView.placeholder = @"输入菜名或食材名搜索";
    }
    return _searchView;
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
        _tableView.tableHeaderView = view;
        _tableView.tableFooterView = view;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
    }
    return _dataArray;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
