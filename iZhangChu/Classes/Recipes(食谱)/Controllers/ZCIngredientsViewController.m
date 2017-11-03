//
//  ZCIngredientsViewController.m
//  掌厨
//
//  Created by Shengping on 17/4/17.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCIngredientsViewController.h"
#import "ZCIngredientsCell.h"
#import "ZCIngredientsDataModel.h"
#import "ZCMacro.h"
#import "ZCIngredientSqlite.h"

#define SQLITE_TABLENAME NSStringFromClass([self class])

@interface ZCIngredientsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *sectionArray;
@end

@implementation ZCIngredientsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor magentaColor];
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[ZCIngredientsCell class] forCellReuseIdentifier:NSStringFromClass([ZCIngredientsCell class])];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary ];
    params[@"methodName"] = @"MaterialSubtype";
    params[@"user_id"] = @"0";
    params[@"token"] = @"0";
    params[@"version"] = @4.92;
    [self requestData:params];
}

- (void)requestData:(NSMutableDictionary *)params {
 
    // 从数据库中取出数据
    NSArray *allData = [[ZCIngredientSqlite shareSqlite] queryAllDataOnTable:SQLITE_TABLENAME];
    if (allData.count != 0) { // 如果数据库中有数据，直接用数据库的
        self.sectionArray = [ZCIngredientsDataModel mj_objectArrayWithKeyValuesArray:allData];
        [self.tableView reloadData];

    } else { // 如果数据库中没有数据，则去网络请求
        [[SPHTTPSessionManager shareInstance] POST:ZCHOSTURL params:params success:^(id  _Nonnull responseObject) {

            // 创建数据库表
            [[ZCIngredientSqlite shareSqlite] creatTableWithTableName:SQLITE_TABLENAME];
            // 保存数据到数据库，数据类型是一个字典数组。当然也可以先转成模型，再把模型数组存进数据库，这样取出数据时直接取出模型
            [[ZCIngredientSqlite shareSqlite] saveToTable:SQLITE_TABLENAME dictArray:responseObject[@"data"][@"data"]];
            // 字典转模型
            self.sectionArray = [ZCIngredientsDataModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
            [self.tableView reloadData];
            
        } failure:^(NSError * _Nonnull error) {
            ZCLog(@"error=%@",error);
        }];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCIngredientsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZCIngredientsCell class]) forIndexPath:indexPath];
    cell.model = self.sectionArray[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCIngredientsDataModel *dataModel = self.sectionArray[indexPath.section];
    return dataModel.cellHeight;
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

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64) style:UITableViewStyleGrouped];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = ZCBackgroundColor;
        // 如果tableView是grouped样式，且没有自定义tableHeaderView和tableFooterView，那么tableView的顶部和底部会多出一段头部高度，这段高度无法修改。只能通过创建一张自定义的view，给个很小很小的高度，然后赋值给tableHeaderView或tableFooterView即可。注意：这张自定义的view的高度不能直接给0，给0的话仍然是默认系统头部高度，要给一个无限接近于0的高度
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.tableHeaderView = view;
        _tableView.tableFooterView = view;
        // 去除表头和表尾高度之后，顶部和尾部还会多出一段高度，那是第一个分区的区头和最后一个分区的区尾造成的，将区头高度和区尾高度设成最小值即可。同样不能设置0，设置0的话系统仍然会强制给默认高度。如果特定分区需要区头高或区尾高度，那在代理方法中写即可
        _tableView.sectionHeaderHeight = CGFLOAT_MIN;
        _tableView.sectionFooterHeight = CGFLOAT_MIN;
        
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
