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

@interface ZCDishInfoBaseViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) CGFloat headerViewH;
@property (nonatomic, copy) NSString *dishes_id;

// 下面的scrollView和tableView是同一个，其实只要一个tableView即可，因为这里的4个子控制器的子View全部是tableView，为了将来有可能collectionView或者scrollView的出现，用一个scrollView统一起来
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ZCDishesInfoHeaderView *headerView;
@property (nonatomic, assign) CGPoint lastContentOffset;




@end

