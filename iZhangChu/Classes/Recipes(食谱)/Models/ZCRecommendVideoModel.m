//
//  ZCRecommendVideoModel.m
//  iZhangChu
//
//  Created by Libo on 17/4/21.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecommendVideoModel.h"

@implementation ZCRecommendVideoModel
- (float)cellHeight {
    if (!_cellHeight) {
        _cellHeight = 40 + kImageViewW + kTopMargin + kTitleFont.lineHeight + kTopMargin + kDescFont.lineHeight*2 + kBottomMargin;
    }
    return _cellHeight;
}
@end
