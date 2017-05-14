//
//  ZCRecommendVideoCell.h
//  iZhangChu
//
//  Created by Shengping on 17/4/21.
//  Copyright © 2017年 iDress. All rights reserved.
//  

#import "ZCRecommendBasicCell.h"
#import "ZCRecommendWidgetItem.h"

@interface ZCRecommendVideoCell : ZCRecommendBasicCell

@end


@interface ZCRecommendVideoItemView : UIView

@property (nonatomic, strong) ZCRecommendWidgetItem *imageItem;
@property (nonatomic, strong) ZCRecommendWidgetItem *textItem;
@property (nonatomic, strong) ZCRecommendWidgetItem *videoItem;
@property (nonatomic, strong) ZCRecommendWidgetItem *descItem;

@end
