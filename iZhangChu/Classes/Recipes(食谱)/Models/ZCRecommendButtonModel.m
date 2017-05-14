//
//  ZCRecommendButtonModel.m
//  iZhangChu
//
//  Created by Shengping on 17/4/21.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecommendButtonModel.h"

@implementation ZCRecommendButtonModel
- (float)cellHeight {
    if (!_cellHeight) {
        _cellHeight = 90.0f;
    }
    return _cellHeight;
}

@end
