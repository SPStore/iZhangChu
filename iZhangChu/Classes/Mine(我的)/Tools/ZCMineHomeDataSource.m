//
//  ZCMineDataSourceTool.m
//  iZhangChu
//
//  Created by Shengping on 17/5/12.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCMineHomeDataSource.h"

@interface ZCMineHomeDataSource()
@end

@implementation ZCMineHomeDataSource

+ (NSArray *)dataSource {
    return [self setupGroups];
}

+ (NSArray *)setupGroups {
    return @[[self group0],
             [self group1],
             [self group2],
             [self group3],
             [self group4],
             ];
    
}

+ (ZCMineBasicGroup *)group0 {
    ZCMineBasicGroup *group = [[ZCMineBasicGroup alloc] init];
    ZCMineBasicModel *model0 = [ZCMineBasicModel modelWithTitle:@"我的消息"];
    model0.targetControllerClass = NSClassFromString(@"ZCMyMessageViewController");
    group.models = @[model0];
    return group;
}

+ (ZCMineBasicGroup *)group1 {
    ZCMineBasicGroup *group = [[ZCMineBasicGroup alloc] init];
    ZCMineBasicModel *model0 = [ZCMineBasicModel modelWithTitle:@"我的红包"];
    model0.rightImage = @"hotpack";
    ZCMineBasicModel *model1 = [ZCMineBasicModel modelWithTitle:@"我的收藏"];
    group.models = @[model0,model1];
    return group;
}


+ (ZCMineBasicGroup *)group2 {
    ZCMineBasicGroup *group = [[ZCMineBasicGroup alloc] init];
    ZCMineBasicModel *model0 = [ZCMineBasicModel modelWithTitle:@"我的缓存"];
    group.models = @[model0];
    return group;
}

+ (ZCMineBasicGroup *)group3 {
    ZCMineBasicGroup *group = [[ZCMineBasicGroup alloc] init];
    ZCMineBasicModel *model0 = [ZCMineBasicModel modelWithTitle:@"喜欢"];
    group.models = @[model0];
    return group;
}

+ (ZCMineBasicGroup *)group4 {
    ZCMineBasicGroup *group = [[ZCMineBasicGroup alloc] init];
    ZCMineBasicModel *model0 = [ZCMineBasicModel modelWithTitle:@"邀请好友"];
    ZCMineBasicModel *model1 = [ZCMineBasicModel modelWithTitle:@"联系我们"];
    group.models = @[model0,model1];
    return group;
}

@end
