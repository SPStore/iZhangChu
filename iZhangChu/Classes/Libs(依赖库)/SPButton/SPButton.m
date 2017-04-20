//
//  SPButton.m
//  WeChat
//
//  Created by leshengping on 16/10/28.
//  Copyright © 2016年 leshengping. All rights reserved.
//

#import "SPButton.h"
#import "UIButton+WebCache.h"


@interface SPButton()
@end

@implementation SPButton

- (instancetype)initWithImageRatio:(CGFloat)ratio {
    if (self = [super init]) {
        _ratio = ratio;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.alpha = 0.6;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.alpha = 0.6;
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    _ratio = _ratio == 0. ? 0.6 : _ratio;
    
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * _ratio;
    return CGRectMake(0, 0, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * _ratio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

- (void)setRatio:(CGFloat)ratio {
    _ratio = ratio;
    [self setNeedsDisplay];
}


@end
