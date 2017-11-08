//
//  SPCarouselView.m
//  轮播图
//
//  Created by leshengping on 16/9/11.
//  Copyright © 2016年 leshengping. All rights reserved.
//

#import "SPCarouselView.h"
#import "UIImageView+WebCache.h" // 如果这里报错，说明没有导入SDWebImage

#define  kWidth  self.bounds.size.width
#define  kHeight self.bounds.size.height

#define kPageControlMargin 10.0f

typedef NS_ENUM(NSInteger, SPCarouseImagesDataStyle){
    SPCarouseImagesDataInLocal,// 本地图片标记
    SPCarouseImagesDataInURL   // URL图片标记
};

@interface SPCarouselView () <UIScrollViewDelegate>

@property(strong, nonatomic) UIScrollView *scrollView;
@property(strong, nonatomic) UIPageControl *pageControl;

// 前一个视图,当前视图,下一个视图
@property(strong, nonatomic) UIImageView *lastImgView;
@property(strong, nonatomic) UIImageView *currentImgView;
@property(strong, nonatomic) UIImageView *nextImgView;

// 图片来源(本地或URL)
@property(nonatomic) SPCarouseImagesDataStyle carouseImagesStyle;

@property(strong, nonatomic) NSTimer *timer;

// kImageCount = array.count,图片数组个数
@property(assign, nonatomic) NSInteger kImageCount;

// 记录nextImageView的下标 默认从1开始
@property(assign, nonatomic) NSInteger nextPhotoIndex;
// 记录lastImageView的下标 默认从 _kImageCount - 1 开始
@property(assign, nonatomic) NSInteger lastPhotoIndex;

//pageControl图片大小
@property (nonatomic, assign) CGSize pageImageSize;

@end

@implementation SPCarouselView

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
    _pageColor = [UIColor grayColor];
    _currentPageColor = [UIColor whiteColor];
}

#pragma mark - Public Method
// 如果是本地图片调用此方法
+(SPCarouselView *)carouselScrollViewWithFrame:(CGRect)frame localImages:(NSArray<NSString *> *)localImages{
    SPCarouselView *carouseScroll =[[SPCarouselView alloc]initWithFrame:frame];
    // 调用set方法
    carouseScroll.localImages = localImages;
    return carouseScroll;
}

// 如果是网络图片调用此方法
+(SPCarouselView *)carouselScrollViewWithFrame:(CGRect)frame urlImages:(NSArray<NSString *> *)urlImages{
    SPCarouselView *carouseScroll = [[SPCarouselView alloc]initWithFrame:frame];
    // 调用set方法
    carouseScroll.urlImages = urlImages;
    return carouseScroll;
}

// 开启定时器
- (void)openTimer {
    // 开启之前一定要先将上一次开启的定时器关闭,否则会跟新的定时器重叠
    [self closeTimer];
    if (_autoScroll) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:self.duration target:self selector:@selector(timerAction) userInfo:self repeats:YES];
        // 当外界滑动其他scrollView时，主线程的RunLoop会切换到UITrackingRunLoopMode这个Mode，执行的也是UITrackingRunLoopMode下的任务（Mode中的item），而timer是添加在NSDefaultRunLoopMode下的，所以timer任务并不会执行，只有当UITrackingRunLoopMode的任务执行完毕，runloop切换到NSDefaultRunLoopMode后，才会继续执行timer事件.
        // 因此，要保证timer事件不中断，就必须把_timer加入到NSRunLoopCommonModes模式下的 RunLoop中。也可以加入到UITrackingRunLoopMode
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

// 关闭定时器
- (void)closeTimer {
    [_timer invalidate];
    _timer = nil;
}

#pragma maek - Private Method

// timer事件
-(void)timerAction{
    // 定时器每次触发都让当前图片为轮播图的第三张ImageView的image
    [_scrollView setContentOffset:CGPointMake(kWidth*2, 0) animated:YES];
}

-(void)configure{
    [self addSubview:self.scrollView];
    // 添加最初的三张imageView
    [self.scrollView addSubview:self.lastImgView];
    [self.scrollView addSubview:self.currentImgView];
    [self.scrollView addSubview:self.nextImgView];
    [self addSubview:self.pageControl];
    
    // 将上一张图片设置为数组中最后一张图片
    [self setImageView:_lastImgView withSubscript:(_kImageCount-1)];
    // 将当前图片设置为数组中第一张图片
    [self setImageView:_currentImgView withSubscript:0];
    // 将下一张图片设置为数组中第二张图片,如果数组只有一张图片，则上、中、下图片全部是数组中的第一张图片
    [self setImageView:_nextImgView withSubscript:_kImageCount == 1 ? 0 : 1];
    
    _scrollView.contentSize = CGSizeMake(kWidth * 3, kHeight);
    //显示中间的图片
    _scrollView.contentOffset = CGPointMake(kWidth, 0);
    
    _pageControl.numberOfPages = self.kImageCount;
    _pageControl.currentPage = 0;
    
    self.nextPhotoIndex = 1;
    self.lastPhotoIndex = _kImageCount - 1;
    
    [self layoutIfNeeded];
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

#pragma mark - setter
// 本地图片
- (void)setLocalImages:(NSArray<NSString *> *)localImages {
    if (localImages.count == 0) return;
    if (![_localImages isEqualToArray:localImages]) {
        _localImages = nil;
        _localImages = [localImages copy];
        //标记图片来源
        self.carouseImagesStyle = SPCarouseImagesDataInLocal;
        //获取数组个数
        self.kImageCount = _localImages.count;
        [self configure];
        
        [self openTimer];
    }
    
}

// 网络图片
- (void)setUrlImages:(NSArray<NSString *> *)urlImages {
    if (urlImages.count == 0) return;
    if (![_urlImages isEqualToArray:urlImages]) {
        _urlImages = nil;
        _urlImages = [urlImages copy];
        //标记图片来源
        self.carouseImagesStyle = SPCarouseImagesDataInURL;
        self.kImageCount = _urlImages.count;
        [self configure];
        
        [self openTimer];
    }
}

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
    if (duration < 1.0f) { // 如果外界不小心设置的时间小于1秒，强制默认2秒。
        duration = 2.0f;
    }
    [self openTimer];
}

// 设置其他小圆点的颜色
- (void)setPageColor:(UIColor *)pageColor {
    _pageColor = pageColor;
    _pageControl.pageIndicatorTintColor = pageColor;
}

// 设置当前小圆点的颜色
- (void)setCurrentPageColor:(UIColor *)currentPageColor {
    _currentPageColor = currentPageColor;
    _pageControl.currentPageIndicatorTintColor = currentPageColor;
}

// 是否显示pageControl
- (void)setShowPageControl:(BOOL)showPageControl {
    _showPageControl = showPageControl;
    self.pageControl.hidden = !_showPageControl;
}

// 设置pageControl的位置
- (void)setPageControlPosition:(SPPageContolPosition)pageControlPosition {
    _pageControlPosition = pageControlPosition;
    
    if (_pageControl.hidden) return;
    
    CGSize size;
    if (!_pageImageSize.width) {// 没有设置图片，系统原有样式
        size = [_pageControl sizeForNumberOfPages:_pageControl.numberOfPages];
        size.height = 8;
    } else { // 设置图片了
        size = CGSizeMake(_pageImageSize.width * (_pageControl.numberOfPages * 2 - 1), _pageImageSize.height);
    }
    
    _pageControl.frame = CGRectMake(0, 0, size.width, size.height);
    
    CGFloat centerY = kHeight - size.height * 0.5 - kPageControlMargin;
    CGFloat pointY = kHeight - size.height - kPageControlMargin;
    
    switch (pageControlPosition) {
        case SPPageContolPositionBottomCenter:
            // 底部中间
            _pageControl.center = CGPointMake(kWidth * 0.5, centerY);
            break;
        case SPPageContolPositionBottomRight:
            // 底部右边
            _pageControl.frame = CGRectMake(kWidth - size.width - kPageControlMargin, pointY, size.width, size.height);
            break;
        case SPPageContolPositionBottomLeft:
            // 底部左边
            _pageControl.frame = CGRectMake(kPageControlMargin, pointY, size.width, size.height);
            break;
        default:
            break;
    }
}

// 设置imageView的内容模式
- (void)setImageMode:(SPCarouselViewImageMode)imageMode {
    _imageMode = imageMode;
    
    switch (imageMode) {
        case SPCarouselViewImageModeScaleToFill:
            _nextImgView.contentMode = _currentImgView.contentMode = _lastImgView.contentMode = UIViewContentModeScaleToFill;
            break;
        case SPCarouselViewImageModeScaleAspectFit:
            _nextImgView.contentMode = _currentImgView.contentMode = _lastImgView.contentMode = UIViewContentModeScaleAspectFit;
            break;
        case SPCarouselViewImageModeScaleAspectFill:
            _nextImgView.contentMode = _currentImgView.contentMode = _lastImgView.contentMode = UIViewContentModeScaleAspectFill;
            break;
        case SPCarouselViewImageModeCenter:
            _nextImgView.contentMode = _currentImgView.contentMode = _lastImgView.contentMode = UIViewContentModeCenter;
            break;
        default:
            break;
    }
}

// 设置pageControl的小圆点图片
- (void)setPageImage:(UIImage *)image currentPageImage:(UIImage *)currentImage {
    if (!image || !currentImage) return;
    self.pageImageSize = image.size;
    [self.pageControl setValue:currentImage forKey:@"_currentPageImage"];
    [self.pageControl setValue:image forKey:@"_pageImage"];
}

#pragma mark - scrollView代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    // 到第一张图片时   (一上来，当前图片的x值是kWidth)
    if (ceil(scrollView.contentOffset.x) <= 0) {  // 右滑
        _nextImgView.image = _currentImgView.image;
        _currentImgView.image = _lastImgView.image;
        // 将轮播图的偏移量设回中间位置
        scrollView.contentOffset = CGPointMake(kWidth, 0);
        _lastImgView.image = nil;
        // 一定要是小于等于，否则数组中只有一张图片时会出错
        if (_lastPhotoIndex <= 0) {
            _lastPhotoIndex = _kImageCount - 1;
            _nextPhotoIndex = _lastPhotoIndex - (_kImageCount - 2);
        } else {
            _lastPhotoIndex--;
            if (_nextPhotoIndex == 0) {
                _nextPhotoIndex = _kImageCount - 1;
            } else {
                _nextPhotoIndex--;
            }
        }
        [self setImageView:_lastImgView withSubscript:_lastPhotoIndex];
    }
    // 到最后一张图片时（最后一张就是轮播图的第三张）
    if (ceil(scrollView.contentOffset.x)  >= kWidth*2) {  // 左滑
        _lastImgView.image = _currentImgView.image;
        _currentImgView.image = _nextImgView.image;
        // 将轮播图的偏移量设回中间位置
        scrollView.contentOffset = CGPointMake(kWidth, 0);
        _nextImgView.image = nil;
        // 一定要是大于等于，否则数组中只有一张图片时会出错
        if (_nextPhotoIndex >= _kImageCount - 1 ) {
            _nextPhotoIndex = 0;
            _lastPhotoIndex = _nextPhotoIndex + (_kImageCount - 2);
        } else{
            _nextPhotoIndex++;
            if (_lastPhotoIndex == _kImageCount - 1) {
                _lastPhotoIndex = 0;
            } else {
                _lastPhotoIndex++;
            }
        }
        [self setImageView:_nextImgView withSubscript:_nextPhotoIndex];
    }
    
    if (_nextPhotoIndex - 1 < 0) {
        self.pageControl.currentPage = _kImageCount - 1;
    } else {
        self.pageControl.currentPage = _nextPhotoIndex - 1;
    }
}

// scrollView结束减速的时候调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

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

#pragma mark - 手势点击事件
-(void)handleTapActionInImageView:(UITapGestureRecognizer *)tap {
    if (self.clickedImageBlock) {
        // 如果_nextPhotoIndex == 0,那么中间那张图片一定是数组中最后一张，我们要传的就是中间那张图片在数组中的下标
        if (_nextPhotoIndex == 0) {
            self.clickedImageBlock(_kImageCount-1);
        }else{
            self.clickedImageBlock(_nextPhotoIndex-1);
        }
    } else if (_delegate && [_delegate respondsToSelector:@selector(carouselView:clickedImageAtIndex:)]) {
        // 如果_nextPhotoIndex == 0,那么中间那张图片一定是数组中最后一张，我们要传的就是中间那张图片在数组中的下标
        if (_nextPhotoIndex == 0) {
            [_delegate carouselView:self clickedImageAtIndex:_kImageCount-1];
        }else{
            [_delegate carouselView:self clickedImageAtIndex:_nextPhotoIndex-1];
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
   
    // 重新设置contentOffset和contentSize对于轮播图下拉放大以及里面的图片跟随放大起着关键作用，因为scrollView放大了，如果不手动设置contentOffset和contentSize，则会导致scrollView的容量不够大，从而导致图片越出scrollview边界的问题
    self.scrollView.contentSize = CGSizeMake(kWidth * 3, kHeight);
    // 奇怪的是，这里如果采用动画效果设置偏移量将不起任何作用
    self.scrollView.contentOffset = CGPointMake(kWidth, 0);

    self.lastImgView.frame = CGRectMake(0, 0, kWidth, kHeight);
    self.currentImgView.frame = CGRectMake(kWidth, 0, kWidth, kHeight);
    self.nextImgView.frame = CGRectMake(kWidth * 2, 0, kWidth, kHeight);
    
    // 等号左边是掉setter方法，右边调用getter方法
    self.pageControlPosition = self.pageControlPosition;
}

#pragma mark - 懒加载
-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.clipsToBounds = YES;
        _scrollView.layer.masksToBounds = YES;
    }
    return _scrollView;
}

-(UIPageControl *)pageControl{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.pageIndicatorTintColor = self.pageColor;
        _pageControl.currentPageIndicatorTintColor = self.currentPageColor;
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

-(UIImageView *)lastImgView{
    if (_lastImgView == nil) {
        _lastImgView = [[UIImageView alloc] init];
    }
    return _lastImgView;
}

-(UIImageView *)currentImgView{
    if (_currentImgView == nil) {
        _currentImgView = [[UIImageView alloc] init];
        // 给当前图片添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapActionInImageView:)];
        [_currentImgView addGestureRecognizer:tap];
        _currentImgView.userInteractionEnabled = YES;
    }
    return _currentImgView;
}

-(UIImageView *)nextImgView{
    if (_nextImgView == nil) {
        _nextImgView = [[UIImageView alloc] init];
    }
    return _nextImgView;
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







