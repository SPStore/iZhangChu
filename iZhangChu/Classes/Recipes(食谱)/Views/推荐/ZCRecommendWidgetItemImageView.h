//
//  ZCRecommendWidgetItemImageView.h
//  iZhangChu
//
//  Created by Shengping on 17/4/21.
//  Copyright © 2017年 iDress. All rights reserved.
//  这个imageView的作用是与ZCRecommendWidgetItem模型绑定在一起

#import <UIKit/UIKit.h>
#import "ZCRecommendWidgetItem.h"

@interface ZCRecommendWidgetItemImageView : UIImageView

@property (nonatomic, strong) ZCRecommendWidgetItem *item;

@property (nonatomic) BOOL showMaskView;

@end
