//
//  ZCSceneInfoListModel.h
//  iZhangChu
//
//  Created by Shengping on 17/5/11.
//  Copyright © 2017年 iDress. All rights reserved.
//  场景详情中的列表模型

#import "ZCBasicModel.h"

@interface ZCSceneInfoListModel : ZCBasicModel

@property (nonatomic, copy) NSString *dishes_name;
@property (nonatomic, assign) NSInteger dishes_id;
@property (nonatomic, copy) NSString *dishes_desc;
@property (nonatomic, copy) NSString *material_video;
@property (nonatomic, copy) NSString *process_video;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, assign) NSInteger like;
@property (nonatomic, copy) NSString *share_url;
@property (nonatomic, strong) NSArray *tags_info;
@end
