//
//  ZCRecommendEmptyModel.m
//  iZhangChu
//
//  Created by Libo on 17/4/24.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecommendEmptyModel.h"

@implementation ZCRecommendEmptyModel
- (float)cellHeight {
    if (!_cellHeight) {
        _cellHeight = 40.0f;
    }
    return _cellHeight;
}
@end
