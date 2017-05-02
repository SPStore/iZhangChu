//
//  ZCRecipesSearchResultModel.h
//  iZhangChu
//
//  Created by Libo on 17/4/29.
//  Copyright © 2017年 iDress. All rights reserved.
//  食谱中的搜索结果模型

#import "ZCBasicModel.h"

@interface ZCRecipesSearchResultModel : ZCBasicModel
@property (nonatomic, copy) NSString *video1;
@property (nonatomic, copy) NSString *dishes_id;
@property (nonatomic, copy) NSString *taste;
@property (nonatomic, copy) NSString *cooking_time;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *hard_level;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *video;
@property (nonatomic, copy) NSString *play;
@property (nonatomic, strong) NSArray *tags_info;
@end
