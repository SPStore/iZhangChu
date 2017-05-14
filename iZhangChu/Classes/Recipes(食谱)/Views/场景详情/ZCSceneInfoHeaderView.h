//
//  ZCSceneInfoHeaderView.h
//  iZhangChu
//
//  Created by Shengping on 17/5/11.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZCSceneInfoDataModel;

@interface ZCSceneInfoHeaderView : UIView

+ (instancetype)shareSceneInfoHeaderView;

@property (nonatomic, strong) ZCSceneInfoDataModel *model;

@end
