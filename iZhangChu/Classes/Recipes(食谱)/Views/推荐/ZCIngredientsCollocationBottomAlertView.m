//
//  ZCIngredientsCollocationBottomAlertView.m
//  iZhangChu
//
//  Created by Shengping on 17/5/9.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCIngredientsCollocationBottomAlertView.h"
#import "ZCMacro.h"
#import "ZCRecipesSearchResultModel.h"
#import "ZCIngredientsCollocationBottomCell.h"

#define kToolBarHeight 60

#define kInset_tb 20
#define kInset_lr 20
#define kPadding 20
#define kCollectionViewCellW (kScreenW-2*kInset_lr-2*kPadding)/3.0

@interface ZCIngredientsCollocationBottomAlertView() <UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation ZCIngredientsCollocationBottomAlertView

- (instancetype)initWithCollectionViewH:(CGFloat)collectionViewH {
    if (self = [super init]) {
        [self addSubview:self.toolBar];
        [self addSubview:self.collectionView];
        
        [self.toolBar makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(0);
            make.height.equalTo(kToolBarHeight);
        }];
        
        [self.collectionView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(self.toolBar.bottom).offset(-1);
            make.height.equalTo(collectionViewH - kToolBarHeight - 1);
        }];
        [self.collectionView registerClass:[ZCIngredientsCollocationBottomCell class] forCellWithReuseIdentifier:NSStringFromClass([ZCIngredientsCollocationBottomCell class])];
    }
    
    return self;
}


- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = [dataArray copy];
    
    self.toolBar.countLabel.text = [NSString stringWithFormat:@"可做%zd道菜",dataArray.count];
    
    [self.collectionView reloadData];
}

- (void)setState:(BottomAlertViewState)state {
    _state = state;
    self.toolBar.rightTopButton.hidden = (state == BottomAlertViewStateDefault);
}

#pragma mark - UICollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCIngredientsCollocationBottomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZCIngredientsCollocationBottomCell class]) forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kPadding;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kPadding;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kCollectionViewCellW, kCollectionViewCellW + 25);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(kInset_tb, kInset_lr, kInset_tb, kInset_lr);
}

- (ZCIngredientsCollocationBottomToolBar *)toolBar {
    
    if (!_toolBar) {
        _toolBar = [[ZCIngredientsCollocationBottomToolBar alloc] init];
        
    }
    return _toolBar;
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = ZCColorRGBA(240, 240, 240, 1);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
    }
    return _collectionView;
}



@end
