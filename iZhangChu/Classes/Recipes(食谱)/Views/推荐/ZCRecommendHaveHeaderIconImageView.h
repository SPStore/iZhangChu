//
//  ZCRecommendHaveHeaderIconImageView.h
//  iZhangChu
//
//  Created by Libo on 17/4/24.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCRecommendWidgetItem.h"

@interface ZCRecommendHaveHeaderIconImageView : UIView

+ (instancetype)haveHeaderIconImageView;

@property (nonatomic, strong) ZCRecommendWidgetItem *imageItem;
@property (nonatomic, strong) ZCRecommendWidgetItem *iconItem;
@property (nonatomic, strong) ZCRecommendWidgetItem *nickItem;
@end
