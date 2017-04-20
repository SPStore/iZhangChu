//
//  ZCRecommendBannerModel.h
//  iZhangChu
//
//  Created by Libo on 17/4/19.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCBasicModel.h"

@interface ZCRecommendBannerModel : ZCBasicModel
@property (nonatomic, assign) NSInteger is_link;
@property (nonatomic, copy) NSString *banner_title;
@property (nonatomic, copy) NSString *banner_link;
@property (nonatomic, assign) NSInteger banner_id;
@property (nonatomic, assign) NSInteger type_id;
@property (nonatomic, copy) NSString *banner_picture;
@end
