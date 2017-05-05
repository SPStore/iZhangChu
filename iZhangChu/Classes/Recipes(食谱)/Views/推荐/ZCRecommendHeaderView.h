//
//  ZCRecommendHeaderView.h
//  iZhangChu
//
//  Created by Libo on 17/4/19.
//  Copyright © 2017年 iDress. All rights reserved.
//  推荐控制器的头部

#import <UIKit/UIKit.h>
#import "SPCarouselView.h"

// 轮播图的高度
#define kCarouselViewHeight kScreenW * 209 / 621
#define kSearchBarHeight 30
#define KSearchBarMargin_tb 12

@interface ZCRecommendHeaderView : UIView

/**
 轮播图的数组
 */
@property (nonatomic, strong) NSArray *banners;

// 轮播图
@property (nonatomic, strong) SPCarouselView *carouselView;

@end
