//
//  ZCRecipesNavigationView.m
//  掌厨
//
//  Created by Libo on 17/4/17.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecipesNavigationView.h"
#import "ZCMacro.h"

@interface ZCRecipesNavigationView()
@property (nonatomic, strong) UIView *bottomLine;       // 底部分割线
@end

@implementation ZCRecipesNavigationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scanButton];
        [self addSubview:self.pageMenu];
        [self addSubview:self.searchButton];
        [self addSubview:self.bottomLine];
    }
    return self;
}

- (SPPageMenu *)pageMenu {
    if (!_pageMenu) {
        _pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(70, 27, kScreenW-140, 37) array:@[@"推荐",@"食材",@"分类"]];
        _pageMenu.buttonFont = [UIFont boldSystemFontOfSize:17];
        _pageMenu.selectedTitleColor = [UIColor blackColor];
        _pageMenu.unSelectedTitleColor = [UIColor grayColor];
        _pageMenu.trackerColor = [UIColor orangeColor];
        _pageMenu.showBreakline = NO;
        _pageMenu.allowBeyondScreen = NO;
        _pageMenu.equalWidths = YES;
        _pageMenu.animationSpeed = 0.1;
    }
    return _pageMenu;
}

- (UIButton *)scanButton {
    if (!_scanButton) {
        _scanButton = [[UIButton alloc] initWithFrame:CGRectMake(16, 32, 20, 30)];
        [_scanButton setImage:[UIImage imageNamed:@"saoyisao"] forState:UIControlStateNormal];
    }
    return _scanButton;
}

- (UIButton *)searchButton {
    if (!_searchButton) {
        _searchButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenW - 36, 32, 20, 30)];
        [_searchButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    }
    return _searchButton;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 63.5, kScreenW, 0.5)];
        _bottomLine.alpha = 0.8;
        _bottomLine.backgroundColor = [UIColor grayColor];
    }
    return _bottomLine;
}

@end
