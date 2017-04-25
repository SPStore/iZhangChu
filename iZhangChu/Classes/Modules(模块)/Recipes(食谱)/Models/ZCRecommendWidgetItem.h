//
//  ZCRecommendWidgetItem.h
//  iZhangChu
//
//  Created by Libo on 17/4/21.
//  Copyright © 2017年 iDress. All rights reserved.
//  每个模型中前套的小模型

#import <Foundation/Foundation.h>

@interface ZCRecommendWidgetItem : NSObject
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *link;
@end
