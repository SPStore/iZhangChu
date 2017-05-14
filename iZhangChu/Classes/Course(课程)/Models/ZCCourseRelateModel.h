//
//  ZCCourseRelateModel.h
//  iZhangChu
//
//  Created by Shengping on 17/4/26.
//  Copyright © 2017年 iDress. All rights reserved.
//  相关课程模型

#import "ZCBasicModel.h"

@interface ZCCourseRelateModel : ZCBasicModel

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSArray *data;

@end

@class ZCCourseDishesModel;

@interface ZCCourseMediaModel : NSObject
@property (nonatomic, copy) NSString *media_id;
@property (nonatomic, copy) NSString *media_type;
@property (nonatomic, strong) ZCCourseDishesModel *relation;
@end

@interface ZCCourseDishesModel : NSObject

@property (nonatomic, copy) NSString *dishes_id;
@property (nonatomic, copy) NSString *dishes_title;
@property (nonatomic, copy) NSString *dishes_image;
@property (nonatomic, copy) NSString *material_video;
@property (nonatomic, copy) NSString *process_video;
@end






