//
//  ZCDishesInfoHeaderView.h
//  iZhangChu
//
//  Created by Libo on 17/6/9.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCDishesInfoModel;

@interface ZCDishesInfoHeaderView : UIView

@property (nonatomic, strong) ZCDishesInfoModel *model;

+ (instancetype)sharedDishesInfoHeaderView;

@end
