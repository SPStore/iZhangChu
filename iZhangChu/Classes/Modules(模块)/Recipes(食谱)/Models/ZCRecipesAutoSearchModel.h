//
//  ZCRecipesAutoSearchModel.h
//  iZhangChu
//
//  Created by Libo on 17/5/1.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCBasicModel.h"

@interface ZCRecipesAutoSearchModel : ZCBasicModel

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSArray *data;

@end


@interface ZCRecipesAutoSearchTopListModel : ZCBasicModel

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *video;

@end
