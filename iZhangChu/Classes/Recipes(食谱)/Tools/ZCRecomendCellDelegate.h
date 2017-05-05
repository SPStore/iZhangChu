//
//  ZCRecomendCellDelegate.h
//  iZhangChu
//
//  Created by Libo on 17/4/29.
//  Copyright © 2017年 iDress. All rights reserved.
//  推荐中的cell代理

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZCRecommendButtonCellButtonType) {
    ZCRecommendButtonCellButtonTypeBasicIntroduce = 1,      // 新手入门
    ZCRecommendButtonCellButtonTypeIngredientsCollocation,  // 食材搭配
    ZCRecommendButtonCellButtonTypeSceneRecipes,            // 场景菜谱
    ZCRecommendButtonCellButtonTypeFoodLive                 // 美食直播
};

@protocol ZCRecomendCellDelegate <NSObject>

@optional;
- (void)buttonOnButtonCellClickedWithButtonType:(ZCRecommendButtonCellButtonType)btnType;

@end

