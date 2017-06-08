//
//  UIBarButtonItem+Style.m
//  SPWeChat
//
//  Created by Shengping on 17/4/11.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "UIBarButtonItem+Style.h"

@implementation UIBarButtonItem (Style)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    CGRect iFrame = btn.frame;
    iFrame.size = btn.currentBackgroundImage.size;
    btn.frame = iFrame;
    // CustomView可以是任意UI控件
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (NSArray *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage offset:(CGFloat)offset
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    CGRect iFrame = btn.frame;
    iFrame.size = btn.currentBackgroundImage.size;
    btn.frame = iFrame;
    // CustomView可以是任意UI控件
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
    // 让button偏移offset个像素
    negativeSpacer.width = offset;
    return [NSArray arrayWithObjects:negativeSpacer, barButton, nil];
}

+ (NSArray *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title titleColor:(UIColor *)color titleFont:(UIFont *)font offset:(CGFloat)offset
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    // btton的文字宽度
    CGFloat btnTitleWidth = [btn.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.width;
    // 设置尺寸
    CGRect iFrame = btn.frame;
    iFrame.size = CGSizeMake(btnTitleWidth, 30);
    btn.frame = iFrame;
    // CustomView可以是任意UI控件
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    // 让右边的button再向右边偏移offset个像素
    negativeSpacer.width = offset;
    return [NSArray arrayWithObjects:negativeSpacer, barButtonItem, nil];
}

+ (NSArray *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image title:(NSString *)title titleColor:(UIColor *)color titleFont:(UIFont *)font offset:(CGFloat)offset
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    // 设置标题
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    // btton的文字宽度
    CGFloat btnTitleWidth = [btn.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.width;
    // 设置尺寸，button的款的＝当前图片的宽度＋文字宽度
    CGRect iFrame = btn.frame;
    iFrame.size = CGSizeMake(btn.currentImage.size.width + btnTitleWidth, 30);
    btn.frame = iFrame;
    // CustomView可以是任意UI控件
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    // 让button偏移offset个像素
    negativeSpacer.width = offset;
    return [NSArray arrayWithObjects:negativeSpacer, barButton, nil];
}
@end
