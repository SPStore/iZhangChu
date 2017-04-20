//
//  ZCBasicViewController.m
//  掌厨
//
//  Created by Libo on 17/4/17.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCBasicViewController.h"
#import "Singleton.h"

@interface ZCBasicViewController ()

@end

@implementation ZCBasicViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 隐藏系统的导航栏
    self.navigationController.navigationBar.hidden = YES;
    
    // 这行代码是调用navigationView的setter方法和getter方法
    self.navigationView = self.navigationView;
}

// 自定义的navigationBar
- (ZCNavigationView *)navigationView {
    if (!_navigationView) {
        _navigationView = [ZCNavigationView sharedInstance];
        _navigationView.backgroundColor = [UIColor whiteColor];
    }
    return _navigationView;
}

- (void)setNavigationView:(ZCNavigationView *)navigationView {
    _navigationView = navigationView;
    [self.view addSubview:self.navigationView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end



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
    
    self.titleLabel = [[UILabel alloc] initWithFrame:self.centerView.bounds];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    [self.centerView addSubview:self.titleLabel];
    self.titleLabel.text = title;
}

- (void)setTitleColor:(UIColor *)color {
    self.titleLabel.textColor = color;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectMake(16, 27, 60, 30);
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(kScreenW-76, 27, 60, 30);
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _rightButton;
}

- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [[UIView alloc] init];
        _centerView.zc_y = 27;
        _centerView.zc_x = (self.zc_width-100)*0.5;
        _centerView.zc_size = CGSizeMake(100, 30);
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
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, 0.5)];
        _bottomLine.alpha = 0.8;
        _bottomLine.backgroundColor = [UIColor grayColor];
    }
    return _bottomLine;
}

- (void)setHideBottomLine:(BOOL)hideBottomLine {
    _hideBottomLine = hideBottomLine;
    _bottomLine.hidden = hideBottomLine;
}


@end
