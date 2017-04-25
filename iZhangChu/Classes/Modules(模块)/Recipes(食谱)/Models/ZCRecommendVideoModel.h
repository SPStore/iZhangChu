//
//  ZCRecommendVideoModel.h
//  iZhangChu
//
//  Created by Libo on 17/4/21.
//  Copyright © 2017年 iDress. All rights reserved.
//  只放视频的cell对应的模型

#import "ZCRecommendBasicModel.h"
#import "ZCMacro.h"

#define kImageViewCount 3.0f
#define kImageViewW (kScreenW / kImageViewCount)

#define kLeftMargin 5.0f
#define kRightMargin 5.0f
#define kTopMargin 5.0f
#define kBottomMargin 5.0f

#define kTitleFont [UIFont systemFontOfSize:14]
#define kDescFont [UIFont systemFontOfSize:13]

@interface ZCRecommendVideoModel : ZCRecommendBasicModel

@end
