//
//  ZCDishesInfoModel.h
//  iZhangChu
//
//  Created by Libo on 17/6/9.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCBasicModel.h"

@interface ZCDishesInfoModel : ZCBasicModel
@property (nonatomic, copy) NSString *click_count;
@property (nonatomic, copy) NSString *material_video;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *taste;
@property (nonatomic, copy) NSString *material_desc;
@property (nonatomic, copy) NSString *cooking_time;
@property (nonatomic, copy) NSString *dishes_name;
@property (nonatomic, copy) NSString *collect_count;
@property (nonatomic, copy) NSString *share_amount;
@property (nonatomic, copy) NSString *dishes_title;
@property (nonatomic, copy) NSString *create_date;
@property (nonatomic, copy) NSString *last_update;
@property (nonatomic, copy) NSString *share_url;
@property (nonatomic, copy) NSString *dishes_id;
@property (nonatomic, copy) NSString *cooke_time;
@property (nonatomic, copy) NSString *dashes_name;
@property (nonatomic, copy) NSString *hard_level;
@property (nonatomic, copy) NSString *dashes_id;
@property (nonatomic, copy) NSString *agreement_amount;
@property (nonatomic, copy) NSString *process_video;
@property (nonatomic, copy) NSString *comment_count;
@property (nonatomic, assign) NSInteger like;
@property (nonatomic, strong) NSArray *extra;
@property (nonatomic, strong) NSArray *commoditys;
@property (nonatomic, strong) NSArray *tags_info;
@property (nonatomic, strong) NSArray *step;
@end
