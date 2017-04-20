//
//  ZCRecommendBasicModel.h
//  iZhangChu
//
//  Created by Libo on 17/4/20.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCRecommendBasicModel : NSObject
@property (nonatomic, assign) NSInteger widget_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger widget_type;
@property (nonatomic, copy) NSString *title_link;
@property (nonatomic, copy) NSString *desc_data;

@property (nonatomic, strong) NSArray *widget_data;

@end
