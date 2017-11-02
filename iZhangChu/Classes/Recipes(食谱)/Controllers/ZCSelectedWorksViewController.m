//
//  ZCSelectedWorksViewController.m
//  iZhangChu
//
//  Created by Libo on 17/6/19.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCSelectedWorksViewController.h"
#import "ZCSelectedWorksCell.h"

@interface ZCSelectedWorksViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ZCSelectedWorksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCSelectedWorksCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([ZCSelectedWorksCell class])];
    
    [self requestData];
}

- (void)requestData {
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    ZCSelectedWorksCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZCSelectedWorksCell class]) forIndexPath:indexPath];
    return cell;
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //_collectionView = [[UICollectionView alloc] initWithFrame:cgre collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
    }
    return _collectionView;
}


@end
