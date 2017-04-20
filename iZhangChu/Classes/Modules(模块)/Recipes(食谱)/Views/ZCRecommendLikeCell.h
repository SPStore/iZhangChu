//
//  ZCRecommendLikeCell.h
//  iZhangChu
//
//  Created by Libo on 17/4/20.
//  Copyright © 2017年 iDress. All rights reserved.
//  猜你喜欢cell

#import "ZCRecommendBasicCell.h"
#import "SPButton.h"
#import "ZCRecommendLikeModel.h"


@interface ZCRecommendLikeCell : ZCRecommendBasicCell
@property (nonatomic, strong) ZCRecommendLikeModel *likeModel;

@property (nonatomic, strong) NSArray *widget_data;
@end



@interface ZCRecommendLikeButton : SPButton
@property (nonatomic, strong) ZCRecommendLikeItem *imageItem;
@property (nonatomic, strong) ZCRecommendLikeItem *textItem;
@end
