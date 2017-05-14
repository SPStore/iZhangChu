//
//  ZCLohasListModel.h
//  iZhangChu
//
//  Created by Libo on 17/5/13.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCBasicModel.h"

@class ZCLohasListDataModel;

@interface ZCLohasListModel : ZCBasicModel

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSArray *top;
@property (nonatomic, strong) NSArray<ZCLohasListDataModel *> *data;

@end

@interface ZCLohasListDataModel : NSObject
@property (nonatomic, assign) NSInteger charge_count;
@property (nonatomic, assign) NSInteger series_id;
@property (nonatomic, assign) NSInteger episode_sum;
@property (nonatomic, copy) NSString *series_name;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSString *album;
@property (nonatomic, copy) NSString *album_logo;
@property (nonatomic, assign) NSInteger episode;
@property (nonatomic, assign) NSInteger play;
@end
