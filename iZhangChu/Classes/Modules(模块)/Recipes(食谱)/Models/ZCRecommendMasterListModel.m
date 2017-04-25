//
//  ZCRecommendMasterListModel.m
//  iZhangChu
//
//  Created by Libo on 17/4/24.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecommendMasterListModel.h"

@implementation ZCRecommendMasterListModel
- (float)cellHeight {
    if (!_cellHeight) {
        _cellHeight = 330.0f;
    }
    return _cellHeight;
}
@end
