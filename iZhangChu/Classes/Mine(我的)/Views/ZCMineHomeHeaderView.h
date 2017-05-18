//
//  ZCMineHomeHeaderView.h
//  iZhangChu
//
//  Created by Shengping on 17/5/13.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SettingBlock)();

@interface ZCMineHomeHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *myBackgroundImageView;

+ (instancetype)shareMineHomeHeaderView;

@property (nonatomic, copy) SettingBlock settingBlock;


@end
