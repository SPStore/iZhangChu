//
//  ZCIngredientsCollocationBottomAlertView.h
//  iZhangChu
//
//  Created by Libo on 17/5/9.
//  Copyright © 2017年 iDress. All rights reserved.
//  从底部弹出来的View

#import <UIKit/UIKit.h>
#import "ZCIngredientsCollocationBottomToolBar.h"

typedef NS_ENUM(NSInteger, BottomAlertViewState) {
    BottomAlertViewStateDefault,  // 默认状态
    BottomAlertViewStateAlert     // 弹出状态
};

@interface ZCIngredientsCollocationBottomAlertView : UIView

@property (nonatomic, strong) ZCIngredientsCollocationBottomToolBar *toolBar;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) BottomAlertViewState state;

- (instancetype)initWithCollectionViewH:(CGFloat)collectionViewH;

@end
