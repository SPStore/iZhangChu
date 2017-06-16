//
//  ZCDishesInfoModel.m
//  iZhangChu
//
//  Created by Libo on 17/6/9.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCDishesInfoModel.h"

@implementation ZCDishesInfoModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"tags_info":@"ZCTagInfoModel",
             @"step":@"ZCDishesMakeStepModel"
             };
}
@end
