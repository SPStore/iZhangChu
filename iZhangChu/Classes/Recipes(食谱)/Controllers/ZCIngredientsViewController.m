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
#import "ZCIngredientsModel.h"
#import "ZCMacro.h"
#import "ZCIngredientSqlite.h"
#import "ZCCollectionViewFlowLayout.h"
#import "ZCDishedInfoViewController.h"

#define SQLITE_TABLENAME NSStringFromClass([self class])

@interface ZCIngredientsViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *sectionArray;
@end

@implementation ZCIngredientsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor magentaColor];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[ZCIngredientsCell class] forCellWithReuseIdentifier:NSStringFromClass([ZCIngredientsCell class])];
    [self.collectionView registerClass:[ZCCollectionHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
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
        [self.collectionView reloadData];

    } else { // 如果数据库中没有数据，则去网络请求
        [[SPHTTPSessionManager shareInstance] POST:ZCHOSTURL params:params success:^(id  _Nonnull responseObject) {

            // 创建数据库表
            [[ZCIngredientSqlite shareSqlite] creatTableWithTableName:SQLITE_TABLENAME];
            // 保存数据到数据库，数据类型是一个字典数组。当然也可以先转成模型，再把模型数组存进数据库，这样取出数据时直接取出模型
            [[ZCIngredientSqlite shareSqlite] saveToTable:SQLITE_TABLENAME dictArray:responseObject[@"data"][@"data"]];
            // 字典转模型
            self.sectionArray = [ZCIngredientsDataModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
            [self.collectionView reloadData];
            
        } failure:^(NSError * _Nonnull error) {
            ZCLog(@"error=%@",error);
        }];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    ZCIngredientsDataModel *dataModel = self.sectionArray[section];
    // 加1是加第一张图片
    return dataModel.data.count+1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCIngredientsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZCIngredientsCell class]) forIndexPath:indexPath];
    ZCIngredientsDataModel *dataModel = self.sectionArray[indexPath.section];
    [cell setModel:dataModel indexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        footer.backgroundColor = ZCBackgroundColor;
        return footer;
    } else if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ZCCollectionHeaderReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        ZCIngredientsDataModel *dataModel = self.sectionArray[indexPath.section];
        header.titleLabel.text = dataModel.text;
        return header;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCIngredientsDataModel *dataModel = self.sectionArray[indexPath.section];
    if (indexPath.row != 0) { // 过滤第一个cell
        ZCIngredientsModel *model = dataModel.data[indexPath.row-1];
        ZCDishedInfoViewController *infoVc = [[ZCDishedInfoViewController alloc] init];
        infoVc.dishes_id = [NSString stringWithFormat:@"%zd",model.id];
        [self.navigationController pushViewController:infoVc animated:YES];
    }
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        ZCCollectionViewFlowLayout *flowLayout = [[ZCCollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64-49) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

@implementation ZCCollectionHeaderReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithWhite:0 alpha:0.7];
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(10, 0, self.bounds.size.width-20, self.bounds.size.height);
}


@end






