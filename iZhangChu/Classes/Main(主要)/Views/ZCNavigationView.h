//
//  ZCNavigationView.h
//  iZhangChu
//
//  Created by Shengping on 17/4/25.
//  Copyright © 2017年 iDress. All rights reserved.
//  自定义导航栏

#import <UIKit/UIKit.h>

@interface ZCNavigationView : UIView

// 左边按钮
@property (nonatomic, strong) UIButton *leftButton;
// 右边按钮
@property (nonatomic, strong) UIButton *rightButton;
// 自定义的View
@property (nonatomic, strong) UIView  *customView;
// titleLabel的最大宽度
@property (nonatomic, assign) CGFloat titleLabelMaxW;
// 标题
@property (nonatomic, copy)   NSString *title;
// 标题颜色
@property (nonatomic, strong) UIColor *titleColor;

// 隐藏底部分割线
@property (nonatomic) BOOL hideBottomLine;


@end
