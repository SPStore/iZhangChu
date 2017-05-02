//
//  ZCRecipesSearchGroup.h
//  iZhangChu
//
//  Created by Libo on 17/4/28.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCBasicModel.h"

@class ZCRecipesSearchModel;

@interface ZCRecipesSearchGroup : ZCBasicModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSMutableArray<ZCRecipesSearchModel *> *searchArray;

@property (nonatomic, assign) float cellHeight;
@end



@interface ZCRecipesSearchModel : ZCBasicModel

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *text;

@end
