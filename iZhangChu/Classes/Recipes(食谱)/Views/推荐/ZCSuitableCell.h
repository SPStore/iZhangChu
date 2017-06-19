//
//  ZCSuitableCell.h
//  iZhangChu
//
//  Created by Libo on 17/6/17.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZCDishesSuitableModel;
@class ZCDishesSuitableItem;

@interface ZCSuitableCell : UITableViewCell

@property (nonatomic, strong) ZCDishesSuitableModel *model;
@property (nonatomic, strong) ZCDishesSuitableItem *item;

@end
