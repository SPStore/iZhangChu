//
//  ZCIngredientsDataModel.m
//  iZhangChu
//
//  Created by Libo on 17/4/24.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCIngredientsDataModel.h"

@implementation ZCIngredientsDataModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"data":@"ZCIngredientsButtonModel"
             };
}

// 提前计算cell的高度,缓存在model中
- (float)cellHeight {
    if (!_cellHeight) {
        NSUInteger count = self.data.count;
        if (count <= 6) {
            // 如果小于等于6，则button最多只有两行，每行三列
            _cellHeight = kTopMargin + kTitleLabelH + kTopMargin + kButtonH * 2 + kButtonPadding + kBottomMargin;
        } else {
            NSInteger rows = 0;
            if ((count - 6) % kMaxCol == 0) {
                rows = (count - 6) / kMaxCol;
            } else {
                rows = (count - 6) / kMaxCol + 1;
            }
            _cellHeight = kTopMargin + kTitleLabelH + kTopMargin + kButtonH * 2 + kButtonPadding + kButtonPadding + rows * kButtonH + (rows - 1) * kButtonPadding + kBottomMargin;
        }
        
    }
    return _cellHeight;
}



@end



