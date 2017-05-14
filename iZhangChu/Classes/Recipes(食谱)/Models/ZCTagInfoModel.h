//
//  ZCTagInfoModel.h
//  iZhangChu
//
//  Created by Shengping on 17/5/11.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCBasicModel.h"

@interface ZCTagInfoModel : ZCBasicModel

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) NSInteger type;

@end
