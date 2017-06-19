//
//  ZCCommensenseCell.h
//  iZhangChu
//
//  Created by Libo on 17/6/17.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZCDishesCommensenseModel;

@interface ZCCommensenseCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) ZCDishesCommensenseModel *model;

@end
