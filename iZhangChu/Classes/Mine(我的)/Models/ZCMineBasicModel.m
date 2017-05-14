//
//  ZCMineBasicModel.m
//  iZhangChu
//
//  Created by Shengping on 17/5/12.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCMineBasicModel.h"

@implementation ZCMineBasicModel
+ (instancetype)modelWithTitle:(NSString *)title icon:(NSString *)icon {
    
    ZCMineBasicModel *model = [[self alloc] init];
    model.title = title;
    model.icon = icon;
    return model;
}

+ (instancetype)modelWithTitle:(NSString *)title {
    return [self modelWithTitle:title icon:nil];
}

- (instancetype)init {
    if (self = [super init]) {
        // 默认显示指示箭头
        self.showArrow = YES;
    }
    return self;
}

@end
