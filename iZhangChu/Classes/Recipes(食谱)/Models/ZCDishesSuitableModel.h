//
//  ZCDishesSuitableModel.h
//  iZhangChu
//
//  Created by Libo on 17/6/17.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCBasicModel.h"

@class ZCDishesSuitableItem;

@interface ZCDishesSuitableModel : ZCBasicModel

@property (nonatomic, copy) NSString *material_id;
@property (nonatomic, copy) NSString *material_name;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, strong) NSArray<ZCDishesSuitableItem *> *suitable_with;
@property (nonatomic, strong) NSArray<ZCDishesSuitableItem *> *suitable_not_with;

@end


@interface ZCDishesSuitableItem : NSObject

@property (nonatomic, copy) NSString *material_id;
@property (nonatomic, copy) NSString *material_name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *suitable_desc;
@property (nonatomic, copy) NSString *image;


@end
