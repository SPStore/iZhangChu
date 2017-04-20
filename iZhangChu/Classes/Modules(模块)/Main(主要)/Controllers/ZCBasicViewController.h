//
//  ZCBasicViewController.h
//  掌厨
//
//  Created by Libo on 17/4/17.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCMacro.h"

@interface ZCNavigationView : UIView
@property (nonatomic, strong) UIButton *leftButton;     // 左边按钮
@property (nonatomic, strong) UIButton *rightButton;    // 右边按钮
@property (nonatomic, copy)   NSString *title;          // 标题
@property (nonatomic, strong) UIView  *centerView;      // 中间的view
@property (nonatomic, strong) UIView *bottomLine;       // 底部分割线
@property (nonatomic, strong) UIColor *titleColor;      // 标题颜色

@property (nonatomic) BOOL hideBottomLine;

+ (instancetype)sharedInstance;

@end



@interface ZCBasicViewController : UIViewController {
    ZCNavigationView *_navigationView;
}

@property (nonatomic, strong) ZCNavigationView  *navigationView; // 自定义的nagationBar


@end
