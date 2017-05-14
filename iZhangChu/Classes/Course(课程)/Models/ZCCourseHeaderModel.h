//
//  ZCCourseHeaderModel.h
//  iZhangChu
//
//  Created by Shengping on 17/4/25.
//  Copyright © 2017年 iDress. All rights reserved.
//  课程头部model

#import "ZCBasicModel.h"

@interface ZCCourseHeaderModel : ZCBasicModel
@property (nonatomic, copy) NSString *series_name;

@property (nonatomic, copy) NSString *album;

@property (nonatomic, assign) NSInteger play;

@property (nonatomic, copy) NSString *share_url;

@property (nonatomic, copy) NSString *series_id;

@property (nonatomic, copy) NSString *series_title;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, assign) NSInteger episode;

@property (nonatomic, copy) NSString *last_update;

@property (nonatomic, copy) NSString *share_description;

@property (nonatomic, copy) NSString *series_image;

@property (nonatomic, copy) NSString *order_no;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, copy) NSString *album_logo;

@property (nonatomic, copy) NSString *relate_activity;

@property (nonatomic, strong) NSArray *data;
@end
