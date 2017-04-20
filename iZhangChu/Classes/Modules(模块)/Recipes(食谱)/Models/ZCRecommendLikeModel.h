//
//  ZCRecommendLikeModel.h
//  iZhangChu
//
//  Created by Libo on 17/4/20.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecommendBasicModel.h"

@interface ZCRecommendLikeItem : NSObject
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *link;
@end

@interface ZCRecommendLikeModel : ZCRecommendBasicModel

@end

