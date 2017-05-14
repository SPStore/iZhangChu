//
//  ZCRecipesNavigationView.h
//  掌厨
//
//  Created by Shengping on 17/4/17.
//  Copyright © 2017年 iDress. All rights reserved.
//  食谱顶部的导航栏

#import <UIKit/UIKit.h>
#import "SPPageMenu.h"

@interface ZCRecipesNavigationView : UIView
@property (nonatomic, strong) SPPageMenu *pageMenu;
@property (nonatomic, strong) UIButton *scanButton;
@property (nonatomic, strong) UIButton *searchButton;
@end
