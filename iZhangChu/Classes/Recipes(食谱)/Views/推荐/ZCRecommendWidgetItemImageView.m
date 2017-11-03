//
//  ZCRecommendWidgetItemImageView.m
//  iZhangChu
//
//  Created by Shengping on 17/4/21.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecommendWidgetItemImageView.h"
#import <UIImageView+WebCache.h>

@interface ZCRecommendWidgetItemImageView()
@property (nonatomic, weak) UIView *maskView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *descLabel;

@end

@implementation ZCRecommendWidgetItemImageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        
        UIView *maskView = [[UIView alloc] init];
        self.maskView = maskView;
        maskView.backgroundColor = [UIColor blackColor];
        maskView.alpha = 0.3;
        [self addSubview:maskView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMaskViewAction:)];
        [maskView addGestureRecognizer:tap];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        self.titleLabel = titleLabel;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:titleLabel];
        
        UILabel *descLabel = [[UILabel alloc] init];
        self.descLabel = descLabel;
        descLabel.textAlignment = NSTextAlignmentCenter;
        descLabel.font = [UIFont systemFontOfSize:10];
        descLabel.textColor = [UIColor whiteColor];
        [self addSubview:descLabel];
    }
    return self;
}

- (void)tapMaskViewAction:(UITapGestureRecognizer *)tap {
    if (self.tapLeftImageViewBlock) {
        self.tapLeftImageViewBlock();
    }
}

- (void)setItem:(ZCRecommendWidgetItem *)item {
    _item = item;
    if ([item.type isEqualToString:@"image"]) {
        [self sd_setImageWithURL:[NSURL URLWithString:item.content] placeholderImage:nil];
    } else if ([item.type isEqualToString:@"text"]) {
        if (item.id % 2 == 0) {
            self.titleLabel.text = item.content;
        } else {
            self.descLabel.text = item.content;
        }
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setShowMaskView:(BOOL)showMaskView{
    _showMaskView = showMaskView;
    self.maskView.hidden = !showMaskView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.maskView.frame = self.bounds;
    CGFloat x = 10.0f;
    CGFloat y = self.bounds.size.height - 40;
    CGFloat w = self.bounds.size.width - 2 * x;
    CGFloat h = 20.0f;
    self.titleLabel.frame = CGRectMake(x, y, w, h);
    self.descLabel.frame = CGRectMake(x, CGRectGetMaxY(self.titleLabel.frame), w, h*0.5);
}

@end





