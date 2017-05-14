//
//  ZCNavigationView.m
//  iZhangChu
//
//  Created by Shengping on 17/4/25.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCNavigationView.h"
#import "Singleton.h"
#import "ZCMacro.h"

@interface ZCNavigationView() {
    UIView *_centerView;
}
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation ZCNavigationView


SingletonM(Instance);

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, kScreenW, 64);
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        [self addSubview:self.centerView];
        [self addSubview:self.bottomLine];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    
    self.titleLabel.text = title;
}

- (void)setTitleColor:(UIColor *)color {
    self.titleLabel.textColor = color;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.centerView.bounds];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        [self.centerView addSubview:self.titleLabel];
    }
    return _titleLabel;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectMake(16, 27, 30, 30);
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _leftButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(kScreenW-76, 27, 60, 30);
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _rightButton;
}

- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [[UIView alloc] init];
        _centerView.zc_y = 27;
        _centerView.zc_x = (self.zc_width-200)*0.5;
        _centerView.zc_size = CGSizeMake(200, 30);
    }
    return _centerView;
}

- (void)setCenterView:(UIView *)centerView {
    if (_centerView != centerView) {
        _centerView = centerView;
    }
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 63.5, kScreenW, 0.5)];
        _bottomLine.alpha = 0.8;
        _bottomLine.backgroundColor = [UIColor grayColor];
    }
    return _bottomLine;
}

- (void)setHideBottomLine:(BOOL)hideBottomLine {
    _hideBottomLine = hideBottomLine;
    _bottomLine.hidden = hideBottomLine;
    if (!hideBottomLine) {
        [self addSubview:self.bottomLine];
    }
}

@end
