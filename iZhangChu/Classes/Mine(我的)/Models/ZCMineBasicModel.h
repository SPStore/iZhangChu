//
//  ZCMineBasicModel.h
//  iZhangChu
//
//  Created by Shengping on 17/5/12.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCBasicModel.h"

@interface ZCMineBasicModel : ZCBasicModel
+ (instancetype)modelWithTitle:(NSString *)title icon:(NSString *)icon;
+ (instancetype)modelWithTitle:(NSString *)title;

/*
 * cell左边的小图标
 */
@property (nonatomic, copy) NSString *icon;
/*
 * cell的标题
 */
@property (nonatomic, copy) NSString *title;
/*
 * cell的是否显示右边的指示器
 */
@property (nonatomic, assign) BOOL showArrow;
/*
 *  点击cell的目标控制器
 */
@property (nonatomic, assign) Class targetControllerClass;
/*
 * 点击cell想做的事情
 */
@property (nonatomic, copy) void (^operation)();
/*
 * cell的高度
 */
@property (nonatomic, assign) float cellHeight;
/*
 * cell的右边显示的图片
 */
@property (nonatomic, copy) NSString *rightImage;

@end
