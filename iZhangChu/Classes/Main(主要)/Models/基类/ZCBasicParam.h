//
//  ZCBasicParam.h
//  iZhangChu
//
//  Created by Libo on 17/5/5.
//  Copyright © 2017年 iDress. All rights reserved.
//  请求参数模型基类

#import <Foundation/Foundation.h>

@interface ZCBasicParam : NSObject

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *user_id;

+ (instancetype)param;

@end
