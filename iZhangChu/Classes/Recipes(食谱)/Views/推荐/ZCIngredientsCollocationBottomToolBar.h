//
//  ZCIngredientsCollocationBottomToolBar.h
//  iZhangChu
//
//  Created by Shengping on 17/5/10.
//  Copyright © 2017年 iDress. All rights reserved.
//  食材搭配中的底部toolbar

#import <UIKit/UIKit.h>

typedef void(^DishButtonClickedBlock)(NSInteger index);

typedef void (^RightTopButtonClickedBlock)();


@interface ZCIngredientsCollocationBottomToolBar : UIView

// 右上角的取消按钮
@property (nonatomic, strong) UIButton *rightTopButton;

// 显示可做几道菜的Label
@property (nonatomic, strong) UILabel *countLabel;

// 添加一个按钮
- (void)addButtonWithTitle:(NSString *)title;

// 移除一个按钮
- (void)removeButtonWithIndex:(NSInteger)index;

// 点击按钮时的block
@property (nonatomic, copy) DishButtonClickedBlock dishButtonClickedBlock;

@property (nonatomic, copy) RightTopButtonClickedBlock rightTopButtonClickedBlock;


@end
