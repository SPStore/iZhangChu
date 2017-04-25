//
//  ZCRecommendImageVideoCell.h
//  iZhangChu
//
//  Created by Libo on 17/4/21.
//  Copyright © 2017年 iDress. All rights reserved.
//  第一张为图片，其余为视频的cell

#import "ZCRecommendBasicCell.h"
#import "ZCRecommendWidgetItem.h"

@interface ZCRecommendImageVideoCell : ZCRecommendBasicCell

@end




@interface ZCRecommendImageVideoRightBigView : UIView
@property (nonatomic, strong) ZCRecommendBasicModel *basicModel;
@end
