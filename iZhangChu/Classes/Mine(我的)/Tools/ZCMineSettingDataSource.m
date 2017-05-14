//
//  ZCMineSettingDataSource.m
//  iZhangChu
//
//  Created by Libo on 17/5/13.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCMineSettingDataSource.h"

@implementation ZCMineSettingDataSource
+ (NSArray *)dataSource {
    return [self setupGroups];
}

+ (NSArray *)setupGroups {
    return @[[self group0],
             [self group1],
             [self group2],
             ];
    
}

+ (ZCMineBasicGroup *)group0 {
    ZCMineBasicGroup *group = [[ZCMineBasicGroup alloc] init];
    ZCMineBasicModel *model0 = [ZCMineBasicModel modelWithTitle:@"分享给好友"];
    group.models = @[model0];
    return group;
}

+ (ZCMineBasicGroup *)group1 {
    ZCMineBasicGroup *group = [[ZCMineBasicGroup alloc] init];
    ZCMineBasicModel *model0 = [ZCMineBasicModel modelWithTitle:@"给我们打分"];
    group.models = @[model0];
    return group;
}


+ (ZCMineBasicGroup *)group2 {
    ZCMineBasicGroup *group = [[ZCMineBasicGroup alloc] init];
    ZCMineBasicModel *model0 = [ZCMineBasicModel modelWithTitle:@"意见反馈"];
    ZCMineBasicModel *model1 = [ZCMineBasicModel modelWithTitle:@"清理缓存"];
    model1.showArrow = NO;
    ZCMineBasicModel *model2 = [ZCMineBasicModel modelWithTitle:@"社区规则"];
    group.models = @[model0,model1,model2];
    return group;
}

@end
