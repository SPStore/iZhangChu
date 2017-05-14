//
//  ZCLohasNagationView.m
//  iZhangChu
//
//  Created by Libo on 17/5/14.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCLohasNagationView.h"
#import "ZCMacro.h"

@interface ZCLohasNagationView()

@end

@implementation ZCLohasNagationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.pageMenu];
        [self addSubview:self.searchButton];
        
        [self.pageMenu makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(60);
            make.right.equalTo(-60);
            make.height.equalTo(44);
            make.top.equalTo(20);
        }];
        
        [self.searchButton makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-16);
            make.centerY.equalTo(self.pageMenu);
            make.width.equalTo(20);
            make.height.equalTo(30);
        }];
    }
    return self;
}

- (SPPageMenu *)pageMenu {
    
    if (!_pageMenu) {
        _pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(60, 20, kScreenW-120, 44) array:@[@"美食IP",@"健康IP",@"台湾IP"]];
        _pageMenu.buttonFont = [UIFont boldSystemFontOfSize:17];
        _pageMenu.selectedTitleColor = [UIColor blackColor];
        _pageMenu.unSelectedTitleColor = [UIColor grayColor];
        _pageMenu.showBreakline = NO;
        _pageMenu.trackerColor = ZCGlobalColor;
        _pageMenu.equalWidths = YES;
        _pageMenu.allowBeyondScreen = NO;
    }
    return _pageMenu;
}

- (UIButton *)searchButton {
    
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    }
    return _searchButton;
}



@end
