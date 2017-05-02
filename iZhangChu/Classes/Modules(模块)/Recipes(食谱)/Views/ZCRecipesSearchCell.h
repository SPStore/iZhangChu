//
//  ZCRecipesSearchCell.h
//  iZhangChu
//
//  Created by Libo on 17/4/28.
//  Copyright © 2017年 iDress. All rights reserved.
//  食谱中的搜索cell

#import "ZCRecipesSearchBasicCell.h"
#import "ZCRecipesSearchGroup.h"

@class ZCRecipesSearchButton;

typedef void (^ButtonClickedOnCellBlock)(ZCRecipesSearchButton *button);

@interface ZCRecipesSearchCell : ZCRecipesSearchBasicCell

// 点击按钮
@property (nonatomic, copy) ButtonClickedOnCellBlock buttonClickedOnCellBlock;

@end


@interface ZCRecipesSearchButton : UIButton

@property (nonatomic, strong) ZCRecipesSearchModel *searchModel;

@end
