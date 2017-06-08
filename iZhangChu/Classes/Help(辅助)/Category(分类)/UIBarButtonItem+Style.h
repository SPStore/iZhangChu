//
//  UIBarButtonItem+Style.h
//  SPWeChat
//
//  Created by Shengping on 17/4/11.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Style)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

/**
 *  创建一个只含图片的item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     item普通图片
 *  @param highImage item高亮图片
 *  @param offset    item的偏移量，如果是导航栏的左边按钮，则offset向左偏移应给负值，如果是右边按钮，向右便偏移应给负值。如果offset给的是0,则默认左(右)按钮与左(右)的间距绝对值为16，给0的话就和上面那个方法效果一致
 */
+ (NSArray *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage offset:(CGFloat)offset;

/**
 *  创建一个只含文字的item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param title     item上的文字
 *  @param offset    item的偏移量，如果是导航栏的左边按钮，则offset向左偏移应给负值，如果是右边按钮，向右便偏移应给负值。如果offset给的是0,则默认左(右)按钮与左(右)间距的绝对值为16
 */
+ (NSArray *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title titleColor:(UIColor *)color titleFont:(UIFont *)font offset:(CGFloat)offset;

/**
 *  创建一个同时含图片和文字的item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     item左边的图片
 *  @param title     item右边的文字
 *  @param offset    item的偏移量，如果是导航栏的左边按钮，则offset向左偏移应给负值，如果是右边按钮，向右便偏移应给负值。如果offset给的是0,则默认左(右)按钮与左(右)的间距绝对值为16
 */
+ (NSArray *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image title:(NSString *)title titleColor:(UIColor *)color titleFont:(UIFont *)font offset:(CGFloat)offset;
@end
