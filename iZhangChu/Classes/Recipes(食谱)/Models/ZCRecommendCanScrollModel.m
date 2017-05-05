//
//  ZCRecommendCanScrollModel.m
//  iZhangChu
//
//  Created by Libo on 17/4/21.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecommendCanScrollModel.h"

@implementation ZCRecommendCanScrollModel
- (float)cellHeight {
    if (!_cellHeight) {
        _cellHeight = 70.0f;
    }
    return _cellHeight;
}
@end
