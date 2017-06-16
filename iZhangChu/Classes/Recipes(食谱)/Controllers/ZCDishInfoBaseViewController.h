//
//  ZCDishInfoBaseViewController.h
//  iZhangChu
//
//  Created by Libo on 17/6/16.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCDishesInfoHeaderView.h"
#import "ZCDishesInfoHeaderContentView.h"

@interface ZCDishInfoBaseViewController : UIViewController

@property (nonatomic, assign) CGFloat headerViewH;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ZCDishesInfoHeaderView *headerView;
@property (nonatomic, assign) CGPoint lastContentOffset;


@end

