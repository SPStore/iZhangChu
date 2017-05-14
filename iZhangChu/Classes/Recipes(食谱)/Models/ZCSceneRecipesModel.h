//
//  ZCSceneRecipesModel.h
//  iZhangChu
//
//  Created by Shengping on 17/5/3.
//  Copyright © 2017年 iDress. All rights reserved.
//  场景菜谱模型

#import "ZCBasicModel.h"

@interface ZCSceneRecipesModel : ZCBasicModel
@property (nonatomic, assign) NSInteger is_new;

@property (nonatomic, assign) NSInteger scene_id;

@property (nonatomic, assign) NSInteger scene_type;

@property (nonatomic, copy) NSString *scene_background;

@property (nonatomic, assign) NSInteger dish_count;

@property (nonatomic, copy) NSString *scene_title;

@property (nonatomic, copy) NSString *scene_desc;
@end
