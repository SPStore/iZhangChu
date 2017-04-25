//
//  ZCRecommendBasicCell.h
//  iZhangChu
//
//  Created by Libo on 17/4/20.
//  Copyright © 2017年 iDress. All rights reserved.
//  基类cell

#import <UIKit/UIKit.h>
#import "ZCMacro.h"
#import "ZCRecommendWidgetItemImageView.h"

#define kTitleHeight 40

@class ZCRecommendBasicModel;

@interface ZCRecommendBasicCell : UITableViewCell

@property (nonatomic, strong) ZCRecommendBasicModel *model;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) CGFloat titleViewW;
@end
