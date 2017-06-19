//
//  ZCDishesMaterialModel.h
//  iZhangChu
//
//  Created by Libo on 17/6/17.
//  Copyright © 2017年 iDress. All rights reserved.
//  食材model（制作步骤中的食材）

#import "ZCBasicModel.h"

@class ZCDishesSpiceItem;
@class ZCDishesMaterialItem;

@interface ZCDishesMaterialModel : ZCBasicModel

@property (nonatomic, copy) NSString *material_image;
@property (nonatomic, strong) NSArray<ZCDishesMaterialItem *> *material;
@property (nonatomic, strong) NSArray<ZCDishesSpiceItem *> *spices;

@end


@interface ZCDishesMaterialItem : NSObject
@property (nonatomic, copy) NSString *material_name;
@property (nonatomic, copy) NSString *material_weight;
@end

@interface ZCDishesSpiceItem : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@end
