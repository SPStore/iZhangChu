//
//  ZCRecipesSearchResultModel.m
//  iZhangChu
//
//  Created by Libo on 17/4/29.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecipesSearchResultModel.h"
#import <MJExtension.h>

@implementation ZCRecipesSearchResultModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"desc" : @"description",
             };
}

@end
