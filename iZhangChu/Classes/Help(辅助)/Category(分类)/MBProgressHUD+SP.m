//
//  MBProgressHUD+SP.m
//  穷游
//
//  Created by leshengping on 17/1/3.
//  Copyright © 2017年 idress. All rights reserved.
//

#import "MBProgressHUD+SP.h"

@implementation MBProgressHUD (SP)

#pragma mark - 成功(正确)提示
+ (instancetype)showSuccess:(NSString *)success {
    
    return [self showSuccess:success toView:nil];
}

+ (instancetype)showSuccess:(NSString *)success toView:(UIView *)view {
    
    return [self show:success icon:@"success.png" view:view];
}

#pragma mark - 错误(失败)提示
+ (instancetype)showError:(NSString *)error {
    
    return [self showError:error toView:nil];
}

+ (instancetype)showError:(NSString *)error toView:(UIView *)view{
    
    return [self show:error icon:@"error.png" view:view];
}

#pragma mark - 普通信息提示
+ (instancetype)showMessage:(NSString *)message {
    
    return [self showMessage:message toView:nil];
}

+ (instancetype)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 蒙版效果,在这里不设置蒙板效果,这个根据个人喜好，要的话就在下面设置
    // hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    // hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    // 设置hud的背景色，半透明的效果只有在枚举MBProgressHUDBackgroundStyleSolidColor下才有效
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.65];
    
    // 设置hud的内容颜色，包括菊花和文字
    hud.contentColor = [UIColor whiteColor];
    
    return hud;

}

#pragma mark -  隐藏
+ (BOOL)hideHUD {
    
    return [MBProgressHUD hideHUDFromView:nil];
}

+ (BOOL)hideHUDFromView:(UIView *)view {
    
    // 显示的时候添加在keyWindow上，隐藏的时候也要在keyWindow上，要对应起来
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    return [MBProgressHUD hideHUDForView:view animated:YES];
}

#pragma mark - 私有方法
+ (instancetype)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view {
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // hud的背景相关设置
    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    hud.bezelView.color = [UIColor blackColor];
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    hud.label.textColor = [UIColor whiteColor];
    
    // 0.7秒之后再消失
    [hud hideAnimated:YES afterDelay:0.7];
    return hud;
}

@end
