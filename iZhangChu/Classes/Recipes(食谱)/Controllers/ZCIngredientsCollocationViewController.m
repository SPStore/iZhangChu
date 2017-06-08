//
//  ZCIngredientsCollocationViewController.m
//  iZhangChu
//
//  Created by Shengping on 17/4/28.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCIngredientsCollocationViewController.h"
#import "ZCIngredientsCollocationCell.h"
#import "ZCIngredientsDataModel.h"
#import "ZCIngredientsButtonModel.h"
#import "ZCIngredientSqlite.h"
#import "ZCIngredientsCollocationBottomAlertView.h"
#import "ZCRecipesSearchResultModel.h"

#define kInset_tb 20
#define kInset_lr 25
#define kPadding 20
#define kCollectionViewCellW (kScreenW-2*kInset_lr-3*kPadding)/4.0
#define kCollectionViewCellH (kCollectionViewCellW+25)

#define kNavigationViewH 64
#define kBottomViewToolBarH 55
#define kBottomViewH kScreenH-kCollectionViewCellH-kInset_tb-kNavigationViewH-kPadding*0.5

static NSString * const ingredientsCollocationCellID = @"ZCIngredientsCollocationCell";

@interface ZCIngredientsCollocationViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITableView *tableView;
// tableView的模型数组
@property (nonatomic, strong) NSArray *dataModelArrayForTableView;
// collectionView的模型数组
@property (nonatomic, strong) NSArray *dataModelArrayForCollectionView;
// 底部的view
@property (nonatomic, strong) ZCIngredientsCollocationBottomAlertView *bottomAlertView;
// 遮罩
@property (nonatomic, strong) UIView *coverView;
// 该按钮用来展开tableview
@property (nonatomic, strong) UIButton *arrowButton;
// 选中的cell对应的模型(tableView)
@property (nonatomic, strong) ZCIngredientsDataModel *selectedDataModel;
// 选中的cell对应的模型数组(collectionView)
@property (nonatomic, strong) NSMutableArray *selectedButtonModelArray;
@end

@implementation ZCIngredientsCollocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"食材搭配";
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.coverView];
    [self.view addSubview:self.arrowButton];
    [self.view addSubview:self.bottomAlertView];
    
    [self layoutUI];

    [self.collectionView registerClass:[ZCIngredientsCollocationCell class] forCellWithReuseIdentifier:ingredientsCollocationCellID];
   
    // 从数据库中取出食材数据
    NSArray *allData = [[ZCIngredientSqlite shareSqlite] queryAllDataOnTable:@"ZCIngredientsViewController"];
    // 转模型
    self.dataModelArrayForTableView = [ZCIngredientsDataModel mj_objectArrayWithKeyValuesArray:allData];
    
    [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

// 底部view中的collectionView数据
- (void)requestBottomViewDataWithIds:(NSArray *)ids {
    NSMutableDictionary *params = [NSMutableDictionary dictionary ];
    if (ids.count == 2) {
        params[@"material_ids"] = [NSString stringWithFormat:@"%@,%@",ids[0],ids[1]];
    }
    if (ids.count == 3) {
        params[@"material_ids"] = [NSString stringWithFormat:@"%@,%@,%@",ids[0],ids[1],ids[2]];
    }
    
    params[@"methodName"] = @"SearchMix";
    params[@"page"] = @1;
    params[@"size"] = @10;
    params[@"user_id"] = @"0";
    params[@"token"] = @"0";
    params[@"version"] = @4.92;
    
    [[SPHTTPSessionManager shareInstance] POST:ZCHOSTURL params:params success:^(id  _Nonnull responseObject) {
        
        self.bottomAlertView.dataArray = [ZCRecipesSearchResultModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
        // 在bottomAlertView内部刷新了collectionView
        
    } failure:^(NSError * _Nonnull error) {
        ZCLog(@"eror = %@",error);
    }];
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataModelArrayForCollectionView.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCIngredientsCollocationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ingredientsCollocationCellID forIndexPath:indexPath];
    ZCIngredientsButtonModel *buttonModel = self.dataModelArrayForCollectionView[indexPath.row];
    cell.indexPath = indexPath;
    cell.buttonModel = buttonModel;
    
    return cell;
}

#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCIngredientsButtonModel *buttonModel = self.dataModelArrayForCollectionView[indexPath.row];
    
    NSInteger index = 0;

    buttonModel.selected = !buttonModel.selected;
    
    if (buttonModel.selected) {
        // 将选中的模型存进数组
        [self.selectedButtonModelArray addObject:buttonModel];
        
    } else {
        index = [self.selectedButtonModelArray indexOfObject:buttonModel];
        // 将未选中的模型移出数组
        [self.selectedButtonModelArray removeObject:buttonModel];
    }
    
    [self.collectionView reloadData];
    
    if (self.selectedButtonModelArray.count > 3) {
        
        // 弹出提示框
        [MBProgressHUD showMessageOnScreenBottom:@"最多只能选择3种食材哦~" hideAfterTime:2.0f];

        // 能进入这个if语句，说明数组中已经有4个模型了，需要删除最后一个模型，并把最后一个模型的selected还原为NO
        ZCIngredientsButtonModel *lastModel = self.selectedButtonModelArray.lastObject;
        lastModel.selected = NO;
        [self.selectedButtonModelArray removeObject:lastModel];
        return;
    }
    
    if (buttonModel.selected) {
        [self.bottomAlertView.toolBar addButtonWithTitle:buttonModel.text];
    } else {
        [self.bottomAlertView.toolBar removeButtonWithIndex:index];
    }
   
    if (self.selectedButtonModelArray.count >= 2) {
        
        NSMutableArray *ids = @[].mutableCopy;
        for (ZCIngredientsButtonModel *buttonModel in self.selectedButtonModelArray) {
            [ids addObject:@(buttonModel.id)];
        }
        
        // 如果不延时，那么self.bottomAlertView的弹出动画将会与self.bottomAlertView添加子控件同时进行，这会导致添加子控件时也会有一个小动画，子控件会有一个从某个点飞出来的感觉，这种动画是masonry的效果，为了消除这种现象，延时0.1秒，当子控件添加完毕时，再去制造弹出动画.
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 请求数据
            [self requestBottomViewDataWithIds:(NSArray *)ids];
            
            [self showBottonView];
        });
        
    } else {
        [self resignBottonBiew];
        
    }
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kPadding;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kPadding;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kCollectionViewCellW, kCollectionViewCellH);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(kInset_tb, kInset_lr, kInset_tb, kInset_lr);
}

#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataModelArrayForTableView.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"tableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }
    ZCIngredientsDataModel *dataModel = self.dataModelArrayForTableView[indexPath.row];
    cell.textLabel.text = dataModel.text;
    if (dataModel.selected) {
        cell.textLabel.textColor = ZCGlobalColor;
    } else {
        cell.textLabel.textColor = [UIColor blackColor];
    }
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 手动调用展开tableView的button的点击方法
    [self closeTableView:self.arrowButton];
    // 滑动到选中的位置
    if (indexPath.row || indexPath.section) { // 必须作判断。因为row和section有可能为nil
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }

    ZCIngredientsDataModel *dataModel = self.dataModelArrayForTableView[indexPath.row];
    
    self.selectedDataModel.selected = NO;
    dataModel.selected = YES;
    self.selectedDataModel = dataModel;
    
    self.dataModelArrayForCollectionView = dataModel.data;
    [self.tableView reloadData];
    // 刷新collectionView
    [self.collectionView reloadData];
    
}

#pragma mark - 按钮点击方法 

- (void)arrowButtonAction:(UIButton *)sender {
 
    [self closeTableView:sender];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)closeTableView:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    self.coverView.hidden = !sender.selected;
    
    // masonry的update方法中，equalTo后面括号里的对象要保持前后统一，否则控制台会打印警告，甚至没有任何效果
    [self.tableView updateConstraints:^(MASConstraintMaker *make) {
        if (sender.selected) {
            make.left.equalTo(self.view.centerX);
        } else {
            make.left.equalTo(self.view.centerX).offset(kScreenW*0.5);
        }
    }];
}

- (void)tapAction:(UITapGestureRecognizer *)tap {

    if (self.bottomAlertView.state == BottomAlertViewStateDefault) {
        [self arrowButtonAction:self.arrowButton];
    } else {
        [self resignBottonBiew];
    }
 
}

// 展示整张bottomView
- (void)showBottonView {
    [self.bottomAlertView updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(kBottomViewH);
        
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    self.bottomAlertView.state = BottomAlertViewStateAlert;
    self.coverView.hidden = NO;
}

// 退出bottomView
- (void)resignBottonBiew {
    if (self.bottomAlertView.state == BottomAlertViewStateAlert) {
        [self.bottomAlertView updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(kBottomViewToolBarH);
        }];
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];
        self.bottomAlertView.state = BottomAlertViewStateDefault;
        self.coverView.hidden = YES;
    }
}

#pragma mark - lazy

- (NSMutableArray *)selectedButtonModelArray {
    
    if (!_selectedButtonModelArray) {
        _selectedButtonModelArray = [NSMutableArray array];
        
    }
    return _selectedButtonModelArray;
}


- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
    }
    return _collectionView;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

- (ZCIngredientsCollocationBottomAlertView *)bottomAlertView {
    
    if (!_bottomAlertView) {
        _bottomAlertView = [[ZCIngredientsCollocationBottomAlertView alloc] initWithCollectionViewH:kBottomViewH];
        _bottomAlertView.translatesAutoresizingMaskIntoConstraints = NO;
        
        WEAKSELF;
        _bottomAlertView.toolBar.dishButtonClickedBlock = ^(NSInteger index) {
            ZCIngredientsButtonModel *buttonModel = weakSelf.selectedButtonModelArray[index];
            buttonModel.selected = NO;
            // 将未选中的模型移出数组
            [weakSelf.selectedButtonModelArray removeObject:buttonModel];
            [weakSelf.collectionView reloadData];
            // 退出bottomView
            [weakSelf resignBottonBiew];
        };
        
        _bottomAlertView.toolBar.rightTopButtonClickedBlock = ^(){
            [weakSelf resignBottonBiew];
        };
    }
    return _bottomAlertView;
}

- (UIView *)coverView {
    
    if (!_coverView) {
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = [UIColor whiteColor];
        // 设置背景颜色半透明（类方法），这种方法设置半透明可以保证子控件不跟着父控件一起alpha
        _coverView.backgroundColor = [UIColor colorWithWhite:0.5f alpha:0.5];
        // 设置背景颜色半透明（对象方法），这种方法设置半透明也可以保证子控件不跟着父控件一起alpha
        //_coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_coverView addGestureRecognizer:tap];
    }
    return _coverView;
}

- (UIButton *)arrowButton {
    
    if (!_arrowButton) {
        _arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _arrowButton.backgroundColor = [UIColor clearColor];
        [_arrowButton setImage:[UIImage imageNamed:@"arrowLeft_12x27_"] forState:UIControlStateNormal];
        [_arrowButton setImage:[UIImage imageNamed:@"arrowRight_12x27_"] forState:UIControlStateSelected];
        [_arrowButton setBackgroundImage:[UIImage imageNamed:@"material_guide_bg03"] forState:UIControlStateNormal];
        [_arrowButton addTarget:self action:@selector(arrowButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _arrowButton.adjustsImageWhenHighlighted = NO;
        // 默认选中
        _arrowButton.selected = YES;

    }
    return _arrowButton;
}

- (void)layoutUI {
    
    [self.collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(kNavigationViewH);
        make.bottom.equalTo(-kBottomViewToolBarH);
    }];
    
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.centerX).offset(kScreenW/2.0);
        make.right.equalTo(0);
        make.top.equalTo(kNavigationViewH);
        make.bottom.equalTo(-kBottomViewToolBarH);
    }];
    
    [self.coverView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kNavigationViewH);
        make.left.equalTo(0);
        make.right.equalTo(self.tableView.left);
        make.bottom.equalTo(-kBottomViewToolBarH);
    }];
    
    [self.arrowButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.tableView);
        make.right.equalTo(self.tableView.left);
        make.width.equalTo(25);
        make.height.equalTo(60);
        
    }];
    
    [self.bottomAlertView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(kBottomViewToolBarH);
    }];
    
    
    [super updateViewConstraints];
}

- (void)dealloc {
    ZCLog(@"%s",__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
