//
//  ZCMineHomeCell.h
//  iZhangChu
//
//  Created by Shengping on 17/5/13.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZCMineBasicModel;

@interface ZCMineHomeCell : UITableViewCell

@property (nonatomic, strong) ZCMineBasicModel *model;

- (void)setupSingleLineWithIndexPath:(NSIndexPath *)indexPath
                   rowCountInSection:(NSInteger)rowCount
                        sectionCount:(NSInteger)sectionCount;

@end
