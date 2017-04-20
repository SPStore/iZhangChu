//
//  SPCarouselScrollView.h
//  轮播图
//
//  Created by leshengping on 16/9/11.
//  Copyright © 2016年 leshengping. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPCarouselScrollView;

@protocol SPCarouseScrollViewDelegate <NSObject>
@optional
//轮播图被点击时触发的代理方法,index为点击的图片下标
-(void)carouseScrollView:(SPCarouselScrollView *)carouseScrollView atIndex:(NSUInteger)index;

@end

typedef NS_ENUM(NSInteger, SPCarouseScrollViewPageContolAliment) {
    SPCarouseScrollViewPageContolAlimentCenter,
    SPCarouseScrollViewPageContolAlimentRight,
    SPCarouseScrollViewPageContolAlimentLeft
};

typedef NS_ENUM(NSInteger, SPCarouselScrollViewImageMode) {
    SPCarouselScrollViewImageModeScaleToFill,       // 默认,充满父控件
    SPCarouselScrollViewImageModeScaleAspectFit,    // 按图片比例显示,少于父控件的部分会留有空白
    SPCarouselScrollViewImageModeScaleAspectFill,   // 按图片比例显示,超出父控件的部分会被剪掉
    SPCarouselScrollViewImageModeCenter             // 处于父控件中心,不会被拉伸,按原始大小显示
};

@interface SPCarouselScrollView : UIView

@property(weak, nonatomic) id<SPCarouseScrollViewDelegate>delegate;

/** 本地图片*/
+(SPCarouselScrollView *)carouselScrollViewWithFrame:(CGRect)frame localImages:(NSArray<NSString *> *)localImages;

/** 网络图片 */
+(SPCarouselScrollView *)carouselScrollViewWithFrame:(CGRect)frame urlImages:(NSArray<NSString *> *)urlImages;

// 存放本地图片名字的数组
@property(strong, nonatomic) NSArray<NSString *> *localImages;

// 存放图片数组的网址
@property(strong, nonatomic) NSArray<NSString *> *urlImages;

/** 图片自动切换间隔时间, 默认设置为 2s */
@property(assign ,nonatomic) NSTimeInterval duration;

/** 是否自动轮播,默认为YES */
@property (assign ,nonatomic, getter=isAutoScroll) BOOL autoScroll;

/** 当前小圆点的颜色 */
@property (strong, nonatomic) UIColor *currentPageControlColor;
/** 其余小圆点的颜色 */
@property (strong, nonatomic) UIColor *pageControlColor;

/** 当前小圆点的图片 */
@property (strong, nonatomic) UIImage *currentPageControlImage;
/** 其余小圆点的图片 */
@property (strong, nonatomic) UIImage *pageControlImage;

/** pageControl的位置,分左,中,右*/
@property (assign, nonatomic) SPCarouseScrollViewPageContolAliment pageContolAliment;

@property (nonatomic, assign, getter=isShowPageControl) BOOL showPageControl;

/** 轮播图上的图片显示模式*/
@property (assign, nonatomic) SPCarouselScrollViewImageMode imageMode;

@end




