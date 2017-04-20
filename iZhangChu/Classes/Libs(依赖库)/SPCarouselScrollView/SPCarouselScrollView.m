//
//  SPCarouselScrollView.m
//  轮播图
//
//  Created by leshengping on 16/9/11.
//  Copyright © 2016年 leshengping. All rights reserved.
//

#import "SPCarouselScrollView.h"
#import "UIImageView+WebCache.h"

typedef NS_ENUM(NSInteger, SPCarouseImagesDataStyle){
    SPCarouseImagesDataInLocal,//本地图片标记
    SPCarouseImagesDataInURL   //URL图片标记
};

// width和height依赖于传进来的frame
#define  kWidth  self.bounds.size.width
#define  kHeight self.bounds.size.height

@interface SPCarouselScrollView () <UIScrollViewDelegate>

@property(strong, nonatomic) UIScrollView *scrollView;
@property(strong, nonatomic) UIPageControl *pageControl;

// 前一个视图,当前视图,下一个视图
@property(strong, nonatomic) UIImageView *lastImgView;
@property(strong, nonatomic) UIImageView *currentImgView;
@property(strong, nonatomic) UIImageView *nextImgView;

// 图片来源(本地或URL)
@property(nonatomic) SPCarouseImagesDataStyle carouseImagesStyle;

@property(strong, nonatomic) NSTimer *timer;

// kCount = array.count,图片数组个数
@property(assign, nonatomic) NSInteger kCount;

// 记录nextImageView的下标 默认从1开始
@property(assign, nonatomic) NSInteger nextPhotoIndex;
// 记录lastImageView的下标 默认从 _kCount - 1 开始
@property(assign, nonatomic) NSInteger lastPhotoIndex;

@property(strong, nonatomic) UILabel *label;

@end

@implementation SPCarouselScrollView

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _duration = 2;
    _autoScroll = YES;
    _pageControlColor = [UIColor grayColor];
    _currentPageControlColor = [UIColor whiteColor];
}

#pragma mark - 类方法
// 如果是本地图片调用此方法
+(SPCarouselScrollView *)carouselScrollViewWithFrame:(CGRect)frame localImages:(NSArray<NSString *> *)localImages{
    SPCarouselScrollView *carouseScroll =[[SPCarouselScrollView alloc]initWithFrame:frame];
    // 调用set方法
    carouseScroll.localImages = localImages;
    return carouseScroll;
}

// 如果是网络图片调用此方法
+(SPCarouselScrollView *)carouselScrollViewWithFrame:(CGRect)frame urlImages:(NSArray<NSString *> *)urlImages{
    SPCarouselScrollView *carouseScroll = [[SPCarouselScrollView alloc]initWithFrame:frame];
    // 调用set方法
    carouseScroll.urlImages = urlImages;
    return carouseScroll;
}

#pragma mark - setter方法专区
// 是否自动轮播
- (void)setAutoScroll:(BOOL)autoScroll {
    _autoScroll = autoScroll;
    
    if (autoScroll) {
        // 开启新的定时器
        [self openTimer];
    } else {
        // 关闭定时器
        [self closeTimer];
    }
}

// 重写duration的set方法,用户可以在外界设置轮播图间隔时间
-(void)setDuration:(NSTimeInterval)duration{
    _duration = duration;
    [self openTimer];
}

// 设置其他小圆点的颜色
- (void)setPageControlColor:(UIColor *)pageControlColor {
    _pageControlColor = pageControlColor;
    _pageControl.pageIndicatorTintColor = pageControlColor;
}

// 设置当前小圆点的颜色
- (void)setCurrentPageControlColor:(UIColor *)currentPageControlColor {
    _currentPageControlColor = currentPageControlColor;
    _pageControl.currentPageIndicatorTintColor = currentPageControlColor;
}

// 设置其他小圆点的图片
- (void)setPageControlImage:(UIImage *)pageControlImage {
    if (pageControlImage == nil) {
        NSLog(@"Error:其余小圆点的图片为nil,请检查");
        return;
    }
    _pageControlImage = pageControlImage;
    [_pageControl setValue:_pageControlImage forKeyPath:@"pageImage"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_currentPageControlImage == nil) {
            NSLog(@"Error:您只设置了其余小圆点的图片,没有设置当前小圆点的图片");
        }
    });
}

- (void)setShowPageControl:(BOOL)showPageControl {
    _showPageControl = showPageControl;
    self.pageControl.hidden = !_showPageControl;
}

// 设置当前小圆点的图片
- (void)setCurrentPageControlImage:(UIImage *)currentPageControlImage {
    if (currentPageControlImage == nil) {
        NSLog(@"Error:当前小圆点的图片为nil,请检查");
        return;
    }
    _currentPageControlImage = currentPageControlImage;
    [_pageControl setValue:_currentPageControlImage forKeyPath:@"currentPageImage"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_pageControlImage == nil) {
            NSLog(@"Error:您只设置了当前小圆点的图片,没有设置其他小圆点的图片");
        }
    });
}

// 设置pageControl的位置
- (void)setPageContolAliment:(SPCarouseScrollViewPageContolAliment)pageContolAliment {
    _pageContolAliment = pageContolAliment;
    
    switch (pageContolAliment) {
        case SPCarouseScrollViewPageContolAlimentCenter:
            // 如果是中间
            _pageControl.frame = CGRectMake(0, 0, kWidth, 30);
            _pageControl.center = CGPointMake(kWidth * 0.5, kHeight - 30 / 2);
            break;
        case SPCarouseScrollViewPageContolAlimentRight:
            // 如果是右边
            _pageControl.frame = CGRectMake(0, 0, kWidth, 30);
            _pageControl.center = CGPointMake(kWidth * 0.5 * 1.5, kHeight - 30 / 2);
            break;
        case SPCarouseScrollViewPageContolAlimentLeft:
            // 如果是左边
            _pageControl.frame = CGRectMake(0, 0, kWidth, 30);
            _pageControl.center = CGPointMake(kWidth * 0.5 * 0.5, kHeight - 30 / 2);
            break;
        default:
            break;
    }
}

// 设置imageView的内容模式
- (void)setImageMode:(SPCarouselScrollViewImageMode)imageMode {
    _imageMode = imageMode;
    
    switch (imageMode) {
        case SPCarouselScrollViewImageModeScaleToFill:
            _lastImgView.contentMode = UIViewContentModeScaleToFill;
            _currentImgView.contentMode = UIViewContentModeScaleToFill;
            _nextImgView.contentMode = UIViewContentModeScaleToFill;
            break;
        case SPCarouselScrollViewImageModeScaleAspectFit:
            _lastImgView.contentMode = UIViewContentModeScaleAspectFit;
            _currentImgView.contentMode = UIViewContentModeScaleAspectFit;
            _nextImgView.contentMode = UIViewContentModeScaleAspectFit;
            break;
        case SPCarouselScrollViewImageModeScaleAspectFill:
            _lastImgView.contentMode = UIViewContentModeScaleAspectFill;
            _currentImgView.contentMode = UIViewContentModeScaleAspectFill;
            _nextImgView.contentMode = UIViewContentModeScaleAspectFill;
            break;
        case SPCarouselScrollViewImageModeCenter:
            _lastImgView.contentMode = UIViewContentModeCenter;
            _currentImgView.contentMode = UIViewContentModeCenter;
            _nextImgView.contentMode = UIViewContentModeCenter;
            break;
        default:
            break;
    }
}

- (void)setLocalImages:(NSArray<NSString *> *)localImages {
    if (_localImages != localImages) {
        _localImages = nil;
        _localImages = localImages;
    }
    //标记图片来源
    self.carouseImagesStyle = SPCarouseImagesDataInLocal;
    //获取数组个数
    self.kCount = _localImages.count;
    [self drawMyView];
    
    [self openTimer];
}

- (void)setUrlImages:(NSArray<NSString *> *)urlImages {
    if (_urlImages != urlImages) {
        _urlImages = nil;
        _urlImages = urlImages;
    }
    //标记图片来源
    self.carouseImagesStyle = SPCarouseImagesDataInURL;
    self.kCount = _urlImages.count;
    [self drawMyView];
    
    [self openTimer];
}

#pragma maek - 其它方法
-(void)drawMyView{
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    self.nextPhotoIndex = 1;
    self.lastPhotoIndex = _kCount - 1;
    
    //想在轮播图上添加其他子控件可在这里添加
    /*
     self.label = [[UILabel alloc]initWithFrame:CGRectMake(50, 500,kWidth-100, 30)];
     self.label.backgroundColor = [UIColor redColor];
     [self addSubview:self.label];
     */
}

// 开启定时器
- (void)openTimer {
    // 开启之前一定要先将上一次开启的定时器关闭,否则会跟新的定时器重叠
    [self closeTimer];
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:self.duration target:self selector:@selector(timerAction) userInfo:self repeats:YES];
        // UITrackingRunLoopMode模式的作用是当用户拖动tableView、collectionView等事件时定时器仍然会处理事件
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
    }
    
}

// 关闭定时器
- (void)closeTimer {
    [_timer invalidate];
}

#pragma mark - 懒加载
-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(kWidth * 3, kHeight);
        //显示中间的图片
        _scrollView.contentOffset = CGPointMake(kWidth, 0);
        _scrollView.delegate = self;
        _scrollView.clipsToBounds = YES;
        _scrollView.layer.masksToBounds = YES;
        // 添加最初的三张imageView
        [_scrollView addSubview:self.lastImgView];
        [_scrollView addSubview:self.currentImgView];
        [_scrollView addSubview:self.nextImgView];
    }
    return _scrollView;
}

-(UIPageControl *)pageControl{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, kWidth, 30)];
        _pageControl.center = CGPointMake(kWidth/2.0, kHeight - 30/2.0);
        _pageControl.userInteractionEnabled = NO;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.pageIndicatorTintColor = self.pageControlColor;
        _pageControl.currentPageIndicatorTintColor = self.currentPageControlColor;
        _pageControl.numberOfPages = self.kCount;
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

-(UIImageView *)lastImgView{
    if (_lastImgView == nil) {
        _lastImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
        // 一上来，将上一张图片设置为数组中最后一张图片
        [self setImageView:_lastImgView withSubscript:(_kCount-1)];
    }
    return _lastImgView;
}

-(UIImageView *)currentImgView{
    if (_currentImgView == nil) {
        _currentImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth, 0, kWidth, kHeight)];
        // 一上来，将当前图片设置为数组中第一张图片
        [self setImageView:_currentImgView withSubscript:0];
        // 给当前图片添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapActionInImageView:)];
        [_currentImgView addGestureRecognizer:tap];
        _currentImgView.userInteractionEnabled = YES;
    }
    return _currentImgView;
}

-(UIImageView *)nextImgView{
    if (_nextImgView == nil) {
        _nextImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth*2, 0,kWidth , kHeight)];
        // 一上来，将下一张图片设置为数组中第二张图片,如果数组只有一张图片，则上、中、下图片全部是数组中的第一张图片
        [self setImageView:_nextImgView withSubscript:_kCount == 1 ? 0 : 1];
    }
    return _nextImgView;
}

//根据下标设置imgView的image
-(void)setImageView:(UIImageView *)imgView withSubscript:(NSInteger)subcript{
    if (self.carouseImagesStyle == SPCarouseImagesDataInLocal) {
        imgView.image = [UIImage imageNamed:self.localImages[subcript]];
    } else{
        //网络图片设置, 如果要使用占位图请自行修改
        [imgView sd_setImageWithURL:[NSURL URLWithString:self.urlImages[subcript]] placeholderImage:nil];
    }
}

#pragma mark - scrollView代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //到第一张图片时   (一上来，当前图片的x值是kWidth)
    if (scrollView.contentOffset.x <= 0) {
        // 这个if语句只有scrollView往右滑时才有会进入
        _nextImgView.image = _currentImgView.image;
        _currentImgView.image = _lastImgView.image;
        // 将轮播图的偏移量设回中间位置
        scrollView.contentOffset = CGPointMake(kWidth, 0);
        _lastImgView.image = nil;
        // 一定要是小于等于，否则数组中只有一张图片时会出错
        if (_lastPhotoIndex <= 0) {
            _lastPhotoIndex = _kCount - 1;
            _nextPhotoIndex = _lastPhotoIndex - (_kCount - 2);
        } else {
            _lastPhotoIndex--;
            if (_nextPhotoIndex == 0) {
                _nextPhotoIndex = _kCount - 1;
            } else {
                _nextPhotoIndex--;
            }
        }
        [self setImageView:_lastImgView withSubscript:_lastPhotoIndex];
    }
    // 到最后一张图片时（最后一张就是轮播图的第三张）
    if (scrollView.contentOffset.x  >= kWidth*2) {
        // 这个if语句只有scrollView往左滑时才会进入
        _lastImgView.image = _currentImgView.image;
        _currentImgView.image = _nextImgView.image;
        // 将轮播图的偏移量设回中间位置
        scrollView.contentOffset = CGPointMake(kWidth, 0);
        _nextImgView.image = nil;
        // 一定要是大于等于，否则数组中只有一张图片时会出错
        if (_nextPhotoIndex >= _kCount - 1 ) {
            _nextPhotoIndex = 0;
            _lastPhotoIndex = _nextPhotoIndex + (_kCount - 2);
        } else{
            _nextPhotoIndex++;
            if (_lastPhotoIndex == _kCount - 1) {
                _lastPhotoIndex = 0;
            } else {
                _lastPhotoIndex++;
            }
        }
        [self setImageView:_nextImgView withSubscript:_nextPhotoIndex];
    }
}

// scrollView结束减速的时候调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //矫正pageCotrol的位置
    _pageControl.currentPage = _nextPhotoIndex - 1;
    if (_nextPhotoIndex - 1 < 0) {
        _pageControl.currentPage = _kCount-1;
    }
}

// 用户将要拖拽时将定时器关闭
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    // 关闭定时器
    [self closeTimer];
}

// 用户结束拖拽时将定时器开启(在打开自动轮播的前提下)
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.autoScroll) {
        [self openTimer];
    }
}

#pragma mark - timer事件
-(void)timerAction{
    // 一上来，轮播图显示的是中间的那张图片，定时器每次触发都让当前图片为轮播图的第三张ImageView的image
    [_scrollView setContentOffset:CGPointMake(2*kWidth, 0) animated:YES];
    _pageControl.currentPage = _nextPhotoIndex;
}

#pragma mark - 手势点击事件
-(void)handleTapActionInImageView:(UITapGestureRecognizer *)tap {
    if (_delegate && [_delegate respondsToSelector:@selector(carouseScrollView:atIndex:)]) {
        // 如果_nextPhotoIndex == 0,那么中间那张图片一定是数组中最后一张，我们要传的就是中间那张图片在数组中的下标
        if (_nextPhotoIndex == 0) {
            [_delegate carouseScrollView:self atIndex:_kCount-1];
        }else{
            [_delegate carouseScrollView:self atIndex:_nextPhotoIndex-1];
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    _scrollView.frame = self.bounds;
//    _lastImgView.frame = CGRectMake(0, 0, kWidth, kHeight);
    _currentImgView.frame = CGRectMake(_scrollView.bounds.size.width+_scrollView.frame.origin.x, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);

//
//    NSLog(@"======%@",NSStringFromCGRect(_currentImgView.frame));
//    _nextImgView.frame = CGRectMake(kWidth*2+self.scrollView.frame.origin.x, 0, kWidth, kHeight);
}

#pragma mark - 系统方法
-(void)willMoveToSuperview:(UIView *)newSuperview {
    if (!newSuperview) {
        [self closeTimer];
    }
}

-(void)dealloc {
    _scrollView.delegate = nil;
}

@end







