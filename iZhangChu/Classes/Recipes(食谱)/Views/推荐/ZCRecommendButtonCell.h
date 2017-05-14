//
//  ZCRecommendButtonCell.h
//  iZhangChu
//
//  Created by Shengping on 17/4/21.
//  Copyright © 2017年 iDress. All rights reserved.
//  推荐控制器中，只装button的cell

#import "ZCRecommendBasicCell.h"
#import "SPButton.h"
#import "ZCRecommendWidgetItem.h"

@interface ZCRecommendButtonCell : ZCRecommendBasicCell

@end

// 新建这个button的目的是为了给其绑定模型
@interface ZCRecommendLikeButton : SPButton
@property (nonatomic, strong) ZCRecommendWidgetItem *imageItem;
@property (nonatomic, strong) ZCRecommendWidgetItem *textItem;
@end
