//
//  ZCRecommendBasicModel.h
//  iZhangChu
//
//  Created by Libo on 17/4/20.
//  Copyright © 2017年 iDress. All rights reserved.
//  根模型

#import <Foundation/Foundation.h>

@interface ZCRecommendBasicModel : NSObject{
    float _cellHeight;
}

@property (nonatomic, assign) NSInteger widget_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger widget_type;
@property (nonatomic, copy) NSString *title_link;
@property (nonatomic, copy) NSString *desc;

@property (nonatomic, strong) NSArray *widget_data;


/**
 cell的高度
 */
@property (nonatomic, assign) float cellHeight;

@end
