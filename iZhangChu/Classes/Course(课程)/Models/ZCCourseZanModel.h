//
//  ZCCourseZanModel.h
//  iZhangChu
//
//  Created by Shengping on 17/4/27.
//  Copyright © 2017年 iDress. All rights reserved.
//  课程点赞模型

#import "ZCBasicModel.h"

@class ZCCourseZanUser;
@interface ZCCourseZanModel : ZCBasicModel

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSArray<ZCCourseZanUser *> *data;

@end


@interface ZCCourseZanUser : NSObject
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *create_time_cn;
@property (nonatomic, copy) NSString *head_img;
@property (nonatomic, assign) NSInteger istalent;
@property (nonatomic, copy) NSString *nick;
@property (nonatomic, copy) NSString *user_id;
@end
