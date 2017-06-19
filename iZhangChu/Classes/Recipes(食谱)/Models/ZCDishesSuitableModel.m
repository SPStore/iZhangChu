//
//  ZCDishesSuitableModel.m
//  iZhangChu
//
//  Created by Libo on 17/6/17.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCDishesSuitableModel.h"

@implementation ZCDishesSuitableModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"suitable_with":@"ZCDishesSuitableItem",
             @"suitable_not_with":@"ZCDishesSuitableItem"
             };
}

@end


@implementation ZCDishesSuitableItem


@end
