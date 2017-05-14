//
//  ZCMineHomeHeaderView.h
//  iZhangChu
//
//  Created by Shengping on 17/5/13.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickedSettignBlock)();

@interface ZCMineHomeHeaderView : UIView

+ (instancetype)shareMineHomeHeaderView;

@property (nonatomic, copy) ClickedSettignBlock clickedBlock;


@end
