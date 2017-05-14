//
//  ZCIngredientsCell.h
//  iZhangChu
//
//  Created by Shengping on 17/4/24.
//  Copyright © 2017年 iDress. All rights reserved.
//  食材cell,同时也是分类控制器的cell，分类控制器是继承于食材控制器的

#import <UIKit/UIKit.h>
#import "ZCIngredientsDataModel.h"
#import "ZCIngredientsButtonModel.h"

@interface ZCIngredientsCell : UITableViewCell
@property (nonatomic, strong) ZCIngredientsDataModel *model;
@end




@interface ZCIngredientsButton : UIButton
@property (nonatomic, strong) ZCIngredientsButtonModel *btnModel;
@end
