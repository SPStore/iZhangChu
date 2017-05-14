//
//  UIImage+General.h
//  iWeChat
//
//  Created by Shengping on 17/4/13.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (General)

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

- (UIImage *)circleImage;
@end
