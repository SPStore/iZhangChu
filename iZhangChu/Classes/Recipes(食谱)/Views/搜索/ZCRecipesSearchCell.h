//
//  ZCRecipesSearchCell.h
//  iZhangChu
//
//  Created by Shengping on 17/4/28.
//  Copyright © 2017年 iDress. All rights reserved.
//  食谱中的搜索cell,展示历史记录和热门搜索

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
