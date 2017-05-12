//
//  ZCSceneInfoDataModel.h
//  iZhangChu
//
//  Created by Libo on 17/5/11.
//  Copyright © 2017年 iDress. All rights reserved.
//  场景详情中的大模型

#import "ZCBasicModel.h"

@interface ZCSceneInfoDataModel : ZCBasicModel

@property (nonatomic, assign) NSInteger is_new;
@property (nonatomic, assign) NSInteger scene_id;
@property (nonatomic, assign) NSInteger scene_type;
@property (nonatomic, copy) NSString *share_url;
@property (nonatomic, copy) NSString *scene_background;
@property (nonatomic, assign) NSInteger dish_count;
@property (nonatomic, copy) NSString *scene_title;
@property (nonatomic, copy) NSString *scene_desc;
@property (nonatomic, strong) NSArray *dishes_list;

@end
