//
//  ZCRecommendImageVideoModel.m
//  iZhangChu
//
//  Created by Shengping on 17/4/21.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecommendImageVideoModel.h"

@implementation ZCRecommendImageVideoModel
- (float)cellHeight {
    if (!_cellHeight) {
        _cellHeight = kCellHeight;
    }
    return _cellHeight;
}
@end
