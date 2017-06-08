//
//  ZCSceneRecipesViewController.m
//  iZhangChu
//
//  Created by Shengping on 17/4/28.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCSceneRecipesViewController.h"
#import "ZCSceneRecipesModel.h"
#import "ZCSceneRecipesCell.h"
#import "ZCMacro.h"

#define cellCol 3
#define cellPadding 1.0f
#define cellW (kScreenW- (cellCol-1)*cellPadding)/cellCol

static NSString * const sceneRecipesCellID = @"sceneRecipesCell";

@interface ZCSceneRecipesViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation ZCSceneRecipesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"全部场景";
    
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCSceneRecipesCell class]) bundle:nil] forCellWithReuseIdentifier:sceneRecipesCellID];
    [self requestData];
}

- (void)requestData {
    NSMutableDictionary *params = [NSMutableDictionary dictionary ];
    params[@"methodName"] = @"SceneList";
    params[@"page"] = @1;
    params[@"size"] = @18;
    params[@"user_id"] = @"0";
    params[@"token"] = @"0";
    params[@"version"] = @4.92;
    [[SPHTTPSessionManager shareInstance] POST:ZCHOSTURL params:params success:^(id  _Nonnull responseObject) {
        
        self.dataArray = [ZCSceneRecipesModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        [self.collectionView reloadData];
    } failure:^(NSError * _Nonnull error) {
        ZCLog(@"%@",error);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCSceneRecipesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:sceneRecipesCellID forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return cellPadding;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return cellPadding;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(cellW, cellW * 1.3);
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH-64) collectionViewLayout:flowLayout];
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
