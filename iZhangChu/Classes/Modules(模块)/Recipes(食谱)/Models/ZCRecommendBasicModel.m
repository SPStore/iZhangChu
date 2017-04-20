//
//  ZCRecommendBasicModel.m
//  iZhangChu
//
//  Created by Libo on 17/4/20.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecommendBasicModel.h"

@implementation ZCRecommendBasicModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"widget_data":@"ZCRecommendLikeItem"
             };
}
// 特别注意：用MJExtension进行字典转模型，如果被转化的模型嵌套模型，不要加- (void)setValue:(id)value forKey:(NSString *)key {} 这个方法，否则内部模型什么数据都得不到。ZCRecommendLikeItem这个模型就是内部的模型
@end
