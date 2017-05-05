//
//  ZCRecommendImageViewTitleCell.h
//  iZhangChu
//
//  Created by Libo on 17/4/24.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecommendBasicCell.h"

@interface ZCRecommendImageViewTitleCell : ZCRecommendBasicCell

@end


@interface ZCRecommendImageViewTitleView : UIView
@property (nonatomic, strong) ZCRecommendWidgetItem *imageItem;
@property (nonatomic, strong) ZCRecommendWidgetItem *titleItem;
@property (nonatomic, strong) ZCRecommendWidgetItem *descItem;
@end
