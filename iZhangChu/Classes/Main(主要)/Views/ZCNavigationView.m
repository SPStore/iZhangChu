//
//  ZCNavigationView.m
//  iZhangChu
//
//  Created by Shengping on 17/4/25.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCNavigationView.h"
#import "ZCMacro.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define kStatusBarH 20
#define kNavigationViewH 44
#define kMargin 16

@interface ZCNavigationView()
// 底部分割线
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation ZCNavigationView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        if (CGRectEqualToRect(frame, CGRectZero)) {
            // 固定导航栏的高度为64
            self.frame = CGRectMake(0, 0, SCREEN_WIDTH, kNavigationViewH+kStatusBarH);
        } else {
            self.frame = frame;
        }
        
        [self setupSubControls];

    }
    return self;
}

// 设置标题
- (void)setTitle:(NSString *)title {
    
    if (![_title isEqualToString:title]) {
        _title = [title copy];
        [self setupTitleLabelSize];
    }
    self.titleLabel.text = title;

}

- (void)setTitleColor:(UIColor *)color {
    self.titleLabel.textColor = color;
}

- (void)setCustomView:(UIView *)customView {
    _customView = customView;
    [self addSubview:customView];
}

- (void)setHideBottomLine:(BOOL)hideBottomLine {
    _hideBottomLine = hideBottomLine;
    self.bottomLine.hidden = hideBottomLine;
}

- (void)setupSubControls {
    
    // 添加左边按钮
    CGFloat leftButtonW = 60;
    CGFloat leftButtonH = 30;
    CGFloat leftButtonX = kMargin;
    CGFloat leftButtonY = kStatusBarH + (kNavigationViewH-leftButtonH)*0.5;
    
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame = CGRectMake(leftButtonX, leftButtonY, leftButtonW, leftButtonH);
    self.leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self addSubview:self.leftButton];
    
    // 添加右边按钮
    CGFloat rightButtonW = 60;
    CGFloat rightButtonH = 30;
    CGFloat rightButtonX = SCREEN_WIDTH-rightButtonW-kMargin;
    CGFloat rightButtonY = leftButtonY;
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = CGRectMake(rightButtonX, rightButtonY, rightButtonW, rightButtonH);
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self addSubview:self.rightButton];
    
    // 添加底部分割线
    CGFloat bottomLineW = SCREEN_WIDTH;
    CGFloat bottomLineH = 0.5f;
    CGFloat bottomLineX = 0;
    CGFloat bottomLineY = kStatusBarH + kNavigationViewH - bottomLineH;
    
    self.bottomLine = [[UIView alloc] init];
    self.bottomLine.frame = CGRectMake(bottomLineX, bottomLineY, bottomLineW, bottomLineH);
    self.bottomLine.backgroundColor = [UIColor grayColor];
    self.bottomLine.alpha = 0.5;
    [self addSubview:self.bottomLine];

}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [self setupTitleLabelSize];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (void)setupTitleLabelSize {
    
    CGSize titleSize = [self sizeForString:_title];

    CGFloat titleX = (SCREEN_WIDTH - titleSize.width) * 0.5;
    CGFloat titleY = kStatusBarH + (kNavigationViewH - titleSize.height)*0.5;
    _titleLabel.frame = (CGRect){{titleX, titleY}, titleSize};

}

- (CGSize)sizeForString:(NSString *)string {
    CGSize titleSize = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
    return titleSize;
}

- (void)setTitleLabelMaxW:(CGFloat)titleLabelMaxW {
    _titleLabelMaxW = titleLabelMaxW;
    
    CGSize titleSize = [self sizeForString:_title];
    if (titleSize.width > titleLabelMaxW) {
        CGRect rect = _titleLabel.frame;
        rect.size.width = titleLabelMaxW;
        _titleLabel.frame = rect;
    }
}

@end
