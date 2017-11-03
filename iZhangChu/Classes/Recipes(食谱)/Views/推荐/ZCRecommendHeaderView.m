//
//  ZCRecommendHeaderView.m
//  iZhangChu
//
//  Created by Shengping on 17/4/19.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecommendHeaderView.h"
#import "ZCMacro.h"
#import "ZCRecommendBannerModel.h"

@interface ZCRecommendHeaderView () 


@end

@implementation ZCRecommendHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

//        self.backgroundColor = ZCBackgroundColor;
        
        [self addSubview:self.carouselView];
        [self addSubview:self.searchBar];
        
    }
    return self;
}

- (void)setBanners:(NSArray *)banners {
    _banners = banners;
    NSMutableArray *urlImages = [NSMutableArray array];
    // 提取模型中的图片
    for (ZCRecommendBannerModel *bannerModel in self.banners) {
        [urlImages addObject:bannerModel.banner_picture];
    }
    // 给轮播图提数据
    self.carouselView.urlImages = urlImages;
}

- (void)tapSerchBar:(UITapGestureRecognizer *)tap {
    ZCLog(@"点击了搜索宽 ");
}

- (UITextField *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UITextField alloc] init];
        _searchBar.backgroundColor = [UIColor whiteColor];
        _searchBar.placeholder = @"输入菜名或食材搜索";
        _searchBar.leftViewMode = UITextFieldViewModeAlways;
        _searchBar.font = [UIFont systemFontOfSize:14];
        _searchBar.textAlignment = NSTextAlignmentCenter;
        _searchBar.textColor = [UIColor grayColor];
        _searchBar.borderStyle = UITextBorderStyleRoundedRect;
        _searchBar.hidden = YES;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 15)];
        UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 15, 15)];
        [leftView addSubview:leftImageView];
        leftImageView.image = [UIImage imageNamed:@"search1"];
        _searchBar.leftView = leftView;
        // KVC获取占位label
        UILabel *placeholderLabel = [_searchBar valueForKey:@"_placeholderLabel"];
        placeholderLabel.textColor = [UIColor grayColor];
    }
    return _searchBar;
}

- (SPCarouselView *)carouselView {
    if (!_carouselView) {
        _carouselView = [[SPCarouselView alloc] init];
        _carouselView.pageControlPosition = SPPageContolPositionBottomRight;
        _carouselView.currentPageColor = ZCGlobalColor;
        _carouselView.pageColor = [UIColor whiteColor];
        _carouselView.duration = 4;
    }
    return _carouselView;
}

- (void)updateConstraints {
    [self.carouselView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self).offset(0);
        make.height.equalTo(kCarouselViewHeight);
    }];
    
    [self.searchBar makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-30);
        make.top.equalTo(self.carouselView.bottom).offset(KSearchBarMargin_tb);
        make.height.equalTo(kSearchBarHeight);
    }];
 
    [super updateConstraints];
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

@end
