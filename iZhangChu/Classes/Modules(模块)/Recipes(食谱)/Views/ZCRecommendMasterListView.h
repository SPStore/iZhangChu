//
//  ZCRecommendMasterListView.h
//  iZhangChu
//
//  Created by Libo on 17/4/24.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCRecommendWidgetItem.h"

@interface ZCRecommendMasterListView : UIView

+ (instancetype)masterListView;

@property (nonatomic, strong) ZCRecommendWidgetItem *iconItem;
@property (nonatomic, strong) ZCRecommendWidgetItem *nickItem;
@property (nonatomic, strong) ZCRecommendWidgetItem *accountItem;
@property (nonatomic, strong) ZCRecommendWidgetItem *fansItem;

@end
