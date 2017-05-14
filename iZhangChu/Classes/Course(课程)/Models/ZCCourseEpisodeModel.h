//
//  ZCCourseEpisodeModel.h
//  iZhangChu
//
//  Created by Shengping on 17/4/25.
//  Copyright © 2017年 iDress. All rights reserved.
//  视频每一集的model

#import "ZCBasicModel.h"

@interface ZCCourseEpisodeModel : ZCBasicModel
@property (nonatomic, copy) NSString *detail;

@property (nonatomic, assign) NSInteger is_collect;

@property (nonatomic, copy) NSString *course_subject;

@property (nonatomic, copy) NSString *course_name;

@property (nonatomic, assign) NSInteger video_watchcount;

@property (nonatomic, copy) NSString *course_introduce;

@property (nonatomic, copy) NSString *ischarge;

@property (nonatomic, copy) NSString *course_video;

@property (nonatomic, assign) NSInteger episode;

@property (nonatomic, copy) NSString *course_image;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *share_url;

@property (nonatomic, copy) NSString *islink;

@property (nonatomic, assign) NSInteger course_id;

@property (nonatomic, assign) NSInteger is_like;
@end
