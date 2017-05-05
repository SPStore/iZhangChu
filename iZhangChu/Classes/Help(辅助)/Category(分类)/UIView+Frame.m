//
//  UIView+Frame.m
//  WeChat
//
//  Created by leshengping on 16/9/29.
//  Copyright © 2016年 leshengping. All rights reserved.
//

#import "UIView+Frame.h"
#import <objc/runtime.h>

@implementation UIView (Frame)
- (void)setZc_x:(CGFloat)zc_x
{
    CGRect frame = self.frame;
    frame.origin.x = zc_x;
    self.frame = frame;
}

- (void)setZc_y:(CGFloat)zc_y
{
    CGRect frame = self.frame;
    frame.origin.y = zc_y;
    self.frame = frame;
}

- (CGFloat)zc_x
{
    return self.frame.origin.x;
}

- (CGFloat)zc_y
{
    return self.frame.origin.y;
}

- (void)setZc_centerX:(CGFloat)zc_centerX
{
    CGPoint center = self.center;
    center.x = zc_centerX;
    self.center = center;
}

- (CGFloat)zc_centerX
{
    return self.center.x;
}

- (void)setZc_centerY:(CGFloat)zc_centerY
{
    CGPoint center = self.center;
    center.y = zc_centerY;
    self.center = center;
}

- (CGFloat)zc_centerY
{
    return self.center.y;
}

- (void)setZc_width:(CGFloat)zc_width
{
    CGRect frame = self.frame;
    frame.size.width = zc_width;
    self.frame = frame;
}

- (void)setZc_height:(CGFloat)zc_height
{
    CGRect frame = self.frame;
    frame.size.height = zc_height;
    self.frame = frame;
}

- (CGFloat)zc_height
{
    return self.frame.size.height;
}

- (CGFloat)zc_width
{
    return self.frame.size.width;
}

- (void)setZc_size:(CGSize)zc_size
{
    CGRect frame = self.frame;
    frame.size = zc_size;
    self.frame = frame;
}

- (CGSize)zc_size
{
    return self.frame.size;
}

- (void)setZc_origin:(CGPoint)zc_origin
{
    CGRect frame = self.frame;
    frame.origin = zc_origin;
    self.frame = frame;
}

- (CGPoint)zc_origin
{
    return self.frame.origin;
}


@end
