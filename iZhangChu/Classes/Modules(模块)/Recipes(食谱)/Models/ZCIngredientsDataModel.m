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

// 提前计算cell的高度
- (float)cellHeight {
    if (!_cellHeight) {
        NSUInteger count = self.data.count;
        if (count <= 6) {
            // 如果小于等于6，则button最多只有两行，每行三列
            _cellHeight = kTopMargin + kTitleLabelH + kTopMargin + kButtonH * 2 + kButtonPadding + kBottomMargin;
        } else {
            
            if ((count - 6) % 5 == 0) {
               _cellHeight = kTopMargin + kTitleLabelH + kTopMargin + kButtonH * 2 + kButtonPadding + kButtonPadding + (count - 6) / 5 * kButtonH + ((count - 6) / 5 - 1) * kButtonPadding + kBottomMargin;
            } else {
               _cellHeight = kTopMargin + kTitleLabelH + kTopMargin + kButtonH * 2 + kButtonPadding + kButtonPadding + ((count - 6) / 5 + 1) * kButtonH + ((count - 6) / 5) * kButtonPadding + kBottomMargin;
            }
            
        }
        
    }
    return _cellHeight;
}

@end
