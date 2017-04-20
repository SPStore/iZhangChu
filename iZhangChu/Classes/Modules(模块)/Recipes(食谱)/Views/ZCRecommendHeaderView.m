//
//  ZCRecommendHeaderView.m
//  iZhangChu
//
//  Created by Libo on 17/4/19.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecommendHeaderView.h"
#import "SPCarouselScrollView.h"
#import "ZCMacro.h"
#import "ZCRecommendBannerModel.h"

@interface ZCRecommendHeaderView ()<SPCarouseScrollViewDelegate>

// 轮播图
@property (nonatomic, strong) SPCarouselScrollView *carouselScrollView;
// 搜索框
@property (nonatomic, strong) UITextField *searchBar;
// 装载新手入门、食材搭配、场景菜谱、美食直播的大view
@property (nonatomic, strong) UIView *menuView;
// 新手入门
@property (nonatomic, strong) UIButton *basicIntroduceBtn;
// 食材搭配
@property (nonatomic, strong) UIButton *ingredientsCollocationBtn;
// 场景菜谱
@property (nonatomic, strong) UIButton *sceneRecipesBtn;
// 美食直播
@property (nonatomic, strong) UIButton *foodLiveBtn;
@end

@implementation ZCRecommendHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        self.backgroundColor = ZCBackgroundColor;
        
        [self addSubview:self.carouselScrollView];
        [self addSubview:self.searchBar];
        [self addSubview:self.menuView];
        
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
    self.carouselScrollView.urlImages = urlImages;
}

- (void)menuBtnClicked:(UIButton *)sender {
    
}

- (UIButton *)foodLiveBtn {
    if (!_foodLiveBtn) {
        _foodLiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_foodLiveBtn setTitle:@"美食直播" forState:UIControlStateNormal];
        [_foodLiveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _foodLiveBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_foodLiveBtn addTarget:self action:@selector(menuBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _foodLiveBtn;
}

- (UIButton *)sceneRecipesBtn {
    if (!_sceneRecipesBtn) {
        _sceneRecipesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sceneRecipesBtn setTitle:@"场景菜谱" forState:UIControlStateNormal];
        [_sceneRecipesBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _sceneRecipesBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_sceneRecipesBtn addTarget:self action:@selector(menuBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sceneRecipesBtn;
}

- (UIButton *)ingredientsCollocationBtn {
    if (!_ingredientsCollocationBtn) {
        _ingredientsCollocationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_ingredientsCollocationBtn setTitle:@"食材搭配" forState:UIControlStateNormal];
        _ingredientsCollocationBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_ingredientsCollocationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ingredientsCollocationBtn addTarget:self action:@selector(menuBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ingredientsCollocationBtn;
}

- (UIButton *)basicIntroduceBtn {
    if (!_basicIntroduceBtn) {
        _basicIntroduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_basicIntroduceBtn setTitle:@"新手入门" forState:UIControlStateNormal];
        [_basicIntroduceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _basicIntroduceBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_basicIntroduceBtn addTarget:self action:@selector(menuBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _basicIntroduceBtn;
}

- (UIView *)menuView {
    if (!_menuView) {
        _menuView = [[UIView alloc] init];
        _menuView.backgroundColor = [UIColor whiteColor];
        [_menuView addSubview:self.basicIntroduceBtn];
        [_menuView addSubview:self.ingredientsCollocationBtn];
        [_menuView addSubview:self.sceneRecipesBtn];
        [_menuView addSubview:self.foodLiveBtn];
    }
    return _menuView;
}

- (UITextField *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UITextField alloc] init];
        _searchBar.backgroundColor = [UIColor whiteColor];
        _searchBar.text = @"输入菜名或食材搜索";
        _searchBar.leftViewMode = UITextFieldViewModeAlways;
        _searchBar.font = [UIFont systemFontOfSize:14];
        _searchBar.textAlignment = NSTextAlignmentCenter;
        _searchBar.textColor = [UIColor grayColor];
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 15)];
        UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 15, 15)];
        [leftView addSubview:leftImageView];
        leftImageView.image = [UIImage imageNamed:@"search1"];
        _searchBar.leftView = leftView;
    }
    return _searchBar;
}

- (SPCarouselScrollView *)carouselScrollView {
    if (!_carouselScrollView) {
        _carouselScrollView = [[SPCarouselScrollView alloc] init];
        _carouselScrollView.delegate = self;
        _carouselScrollView.pageContolAliment = SPCarouseScrollViewPageContolAlimentRight;
        _carouselScrollView.currentPageControlColor = ZCGlobalColor;
        _carouselScrollView.pageControlColor = [UIColor whiteColor];
    }
    return _carouselScrollView;
}

- (void)updateConstraints {
    [self.carouselScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self).offset(0);
        make.height.equalTo(kScreenW * 209 / 621);
    }];
    
    [self.searchBar makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-30);
        make.top.equalTo(self.carouselScrollView.bottom).offset(10);
        make.height.equalTo(30);
    }];
    
    [self.menuView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.searchBar.bottom).offset(10);
        make.height.equalTo(60);
    }];
    
    [self.menuView.subviews makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.bottom.equalTo(0);
    }];
    // 左右间距为0，间隔为0，宽度自适应
    [self.menuView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    
    [super updateConstraints];
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

@end
