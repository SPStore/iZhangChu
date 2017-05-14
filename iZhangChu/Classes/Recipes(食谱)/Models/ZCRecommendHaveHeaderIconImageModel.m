//
//  ZCRecommendHaveHeaderIconImageModel.m
//  iZhangChu
//
//  Created by Shengping on 17/4/24.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecommendHaveHeaderIconImageModel.h"

@implementation ZCRecommendHaveHeaderIconImageModel
- (float)cellHeight {
    if (!_cellHeight) {
        _cellHeight = 220.0f;
    }
    return _cellHeight;
}
@end
