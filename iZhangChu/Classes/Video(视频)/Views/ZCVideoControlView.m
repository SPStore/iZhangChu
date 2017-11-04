//
//  ZCVideoControlView.m
//  iZhangChu
//
//  Created by Libo on 2017/11/4.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCVideoControlView.h"
#import "SPVideoPlayer.h"
#import "SPLoadingHUD.h"

// 几秒后隐藏
static const CGFloat SPPlayerAnimationTimeInterval             = 3.0f;
// 显示controlView的动画时间
static const CGFloat SPPlayerControlBarAutoFadeOutTimeInterval = 0.15f;

@interface ZCVideoControlView()
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIView *voiceView;
@property (weak, nonatomic) IBOutlet UIProgressView *voiceProgressView;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseButton;
@property (weak, nonatomic) IBOutlet UIButton *fast_forwardButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *fast_backwardButton;
@property (weak, nonatomic) IBOutlet UIButton *lastButton;
@property (weak, nonatomic) IBOutlet UIView *operationView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (nonatomic, assign) BOOL showing;
@property (nonatomic, assign) BOOL draggedBySlider;

@property (nonatomic, strong) SPLoadingHUD *hud;
@end

@implementation ZCVideoControlView

+ (instancetype)shareVideoControlView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.voiceView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [self.slider setThumbImage:[UIImage imageNamed:@"play_slider"] forState:UIControlStateNormal];
    UITapGestureRecognizer *sliderTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSliderAction:)];
    [self.slider addGestureRecognizer:sliderTap];
    
    self.showing = YES;
    
    // 监听播放状态的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayerStateChanged:) name:SPVideoPlayerStateChangedNSNotification object:nil];
    // 监听播放进度的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayerProgressValueChanged:) name:SPVideoPlayerProgressValueChangedNSNotification object:nil];
    // 视频播放进度将要跳转
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayerWillJump:) name:SPVideoPlayerWillJumpNSNotification object:nil];
    // 视频播放进度条转完毕
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayerDidJumped:) name:SPVideoPlayerDidJumpedNSNotification object:nil];
    // app退到后台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground) name:UIApplicationWillResignActiveNotification object:nil];
    // app进入前台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterPlayground) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

#pragma mark - 通知方法
/** 播放状态发生了改变 */
- (void)videoPlayerStateChanged:(NSNotification *)notification {
    
    SPVideoPlayerPlayState state = [notification.userInfo[@"playState"] integerValue];
    
    switch (state) {
        case SPVideoPlayerPlayStateReadyToPlay:    // 准备播放
            
            [self showHUDWithTitle:@"即将播放"];
            
            break;
        case SPVideoPlayerPlayStatePlaying:        // 正在播放
        {
            [self hideHUD];
            self.playOrPauseButton.selected = YES;
            [self sp_playerCancelAutoFadeOutControlView];
            // 先取消原来的延迟隐藏，再重新显示延迟隐藏
            if (self.showing) {
                [self sp_playerShowControlView];
            }
        }
            break;
        case SPVideoPlayerPlayStatePause:          // 暂停播放
            self.playOrPauseButton.selected = NO;
            [self sp_playerCancelAutoFadeOutControlView];
            break;
        case SPVideoPlayerPlayStateBuffering:      // 缓冲中
            // 显示加载指示器
            [self showHUDWithTitle:@"正在全力加载..."];
            break;
        case SPVideoPlayerPlayStateBufferSuccessed: // 缓冲成功

            break;
        case SPVideoPlayerPlayStateEndedPlay:      // 播放结束
        {
            [self hideHUD];
            self.showing = NO;
            // 隐藏controlView
            [self hideControlView];
        }
            break;
        default:
            break;
    }
}

/** 播放进度发生了改变 */
- (void)videoPlayerProgressValueChanged:(NSNotification *)notification {
    // 当前时间
    CGFloat currentTime = [notification.userInfo[@"currentTime"] floatValue];
    // 总时间
    CGFloat totalTime = [notification.userInfo[@"totalTime"] floatValue];
    // 当前时间与总时间之比
    CGFloat value = [notification.userInfo[@"value"] floatValue];
    
    SPVideoPlayerPlayProgressState playProgressState = [notification.userInfo[@"playProgressState"] integerValue];

    // 秒数转时分秒
    double current_hours = floorf(currentTime/(60.0*60.0));
    double current_minutes = floorf(fmod(currentTime, 60.0*60.0)/60.0);
    double current_seconds = fmod(currentTime, 60.0);
    
    double total_hours = floorf(totalTime/(60.0*60.0));
    double total_minutes = floorf(fmod(totalTime, 60.0*60.0)/60.0);;
    double total_seconds = fmod(totalTime, 60.0);

    NSString *currentTimeString;
    // 更新slider
    if (!self.draggedBySlider) { // 如果是因为滑动slider而导致的快进或快退，则可以不用更新slider的值，如果不加判断,当滑动slider时，就更新了2次slider()。如果2次更新在同一线程上，可以不用加此判断，如果在不同线程上，不加判断slider的跟踪按钮会有小小的闪跳(这里可不加，加了更好)
        self.slider.value       = value;
    }
    
    // 更新slider
    if (current_hours > 0) {
        if (current_hours < 1) {
            current_hours = 0.00;
        }
        currentTimeString = [NSString stringWithFormat:@"%02.0f:%02.0f:%02.0f", current_hours, current_minutes, current_seconds];
    } else {
        
        if (current_minutes < 1) {
            current_minutes = 0.00;
        }
        currentTimeString = [NSString stringWithFormat:@"%02.0f:%02.0f", current_minutes, current_seconds];
    }
    
    NSString *totalTimeString;
    if (total_hours > 0) {
        if (total_hours < 1) {
            total_hours = 0.00;
        }
        totalTimeString = [NSString stringWithFormat:@"%02.0f:%02.0f:%02.0f", total_hours, total_minutes, total_seconds];
    } else {
        if (total_minutes < 1) {
            total_minutes = 0.00;
        }
        totalTimeString = [NSString stringWithFormat:@"%02.0f:%02.0f", total_minutes, total_seconds];
    }
    self.currentTimeLabel.text = currentTimeString;
    self.totalTimeLabel.text = totalTimeString;
    
    if (playProgressState != SPVideoPlayerPlayProgressStateNomal) { // 快进或快退状态
#warning UNDO 改成label
        [self showHUDWithTitle:[NSString stringWithFormat:@"%.0f%%",value*100]];
        self.hud.activityIndicatorPosition = SPActivityIndicatorPositionNone;
        self.hud.margin = 10;
        self.hud.minSize = CGSizeMake(40, 40);
        self.hud.bezelView.appearance = SPLoadingHUDAppearanceRect;
    }
}

/** 视频播放进度将要发生真实跳转，此时也正是快进快退刚结束 */
- (void)videoPlayerWillJump:(NSNotification *)noti {
    [self hideHUD];
    [self showHUDWithTitle:@"正在全力加载"];
}

/** 视频播放进度结束跳转 */
- (void)videoPlayerDidJumped:(NSNotification *)noti {
    // 滑动结束延时隐藏controlView
    [self autoFadeOutControlView];
    [self hideHUD];
}

/**
 *  应用退到后台
 */
- (void)appDidEnterBackground {
    [self sp_playerCancelAutoFadeOutControlView];
}

/**
 *  应用进入前台
 */
- (void)appDidEnterPlayground {
    [self sp_playerShowControlView];
}

#pragma mark - Action

- (IBAction)playOrPauseButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(sp_controlViePlayOrPauseButtonClicked:)]) {
        [self.delegate sp_controlViePlayOrPauseButtonClicked:sender];
    }
    // 取消延时隐藏controlView,如果在这里不取消，则SPPlayerAnimationTimeInterval秒后controlView会自动隐藏，而我要的效果是点击了播放暂停按钮后，永远不隐藏
    [self sp_playerCancelAutoFadeOutControlView];
}

- (IBAction)fast_fowwardButtonAction:(UIButton *)sender {
    
}

- (IBAction)nextButtonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(sp_controlViewNextButtonClicked:)]) {
        [self.delegate sp_controlViewNextButtonClicked:sender];
    }
}

- (IBAction)fast_backwardButtonAction:(UIButton *)sender {
    
}

- (IBAction)lastButtonAction:(UIButton *)sender {
    
}

- (IBAction)sliderTouchBegan:(UISlider *)sender {
    [self sp_playerCancelAutoFadeOutControlView];
    if ([self.delegate respondsToSelector:@selector(sp_controlViewSliderTouchBegan:)]) {
        [self.delegate sp_controlViewSliderTouchBegan:sender];
    }
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    self.draggedBySlider = YES;
    if ([self.delegate respondsToSelector:@selector(sp_controlViewSliderValueChanged:)]) {
        [self.delegate sp_controlViewSliderValueChanged:sender];
    }
}

- (IBAction)sliderTouchEnded:(UISlider *)sender {
    self.showing = YES;
    self.draggedBySlider = NO;
    if ([self.delegate respondsToSelector:@selector(sp_controlViewSliderTouchEnded:)]) {
        [self.delegate sp_controlViewSliderTouchEnded:sender];
    }
}

- (void)tapSliderAction:(UITapGestureRecognizer *)tap {
    if ([tap.view isKindOfClass:[UISlider class]]) {
        UISlider *slider = (UISlider *)tap.view;
        CGPoint point = [tap locationInView:slider];
        CGFloat length = slider.frame.size.width;
        // 视频跳转的value
        CGFloat tapValue = point.x / length;
        if ([self.delegate respondsToSelector:@selector(sp_controlViewSliderTaped:)]) {
            [self.delegate sp_controlViewSliderTaped:tapValue];
        }
    }
}

- (IBAction)backButton:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(sp_controlViewBackButtonClicked:)]) {
        [self.delegate sp_controlViewBackButtonClicked:sender];
    }
}

#pragma mark - 显示和隐藏控制层

// 显示控制层,不含动画
- (void)showControlView {
    self.showing = YES;
    self.voiceView.alpha     = 1;
    self.bottomView.alpha    = 1;
    self.topView.alpha       = 1;
    self.operationView.alpha = 1;
    self.backgroundView.alpha = 0.5;
}

// 隐藏控制层，不含动画
- (void)hideControlView {
    self.showing = NO;
    self.topView.alpha       = 0;
    self.bottomView.alpha    = 0;
    self.voiceView.alpha     = 0;
    self.operationView.alpha = 0;
    self.backgroundView.alpha = 0;
}

// SPPlayerAnimationTimeInterval秒后自动隐藏
- (void)autoFadeOutControlView {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(sp_playerHideControlView) object:nil];
    [self performSelector:@selector(sp_playerHideControlView) withObject:nil afterDelay:SPPlayerAnimationTimeInterval];
}

// 显示控制层,SPPlayerAnimationTimeInterval秒后自动隐藏
- (void)sp_playerShowControlView {

    [self sp_playerCancelAutoFadeOutControlView];
    [UIView animateWithDuration:SPPlayerControlBarAutoFadeOutTimeInterval animations:^{
        [self showControlView];
    } completion:^(BOOL finished) {
        self.showing = YES;
        [self autoFadeOutControlView];
    }];
}

// 隐藏控制层,含动画
- (void)sp_playerHideControlView {
    [self sp_playerCancelAutoFadeOutControlView];
    [UIView animateWithDuration:SPPlayerControlBarAutoFadeOutTimeInterval animations:^{
        [self hideControlView];
    } completion:^(BOOL finished) {
        self.showing = NO;
    }];
}

// 取消延时隐藏controlView的方法
- (void)sp_playerCancelAutoFadeOutControlView {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(sp_playerHideControlView) object:nil];
}

- (void)sp_playerShowOrHideControlView {
    
    if (self.showing) {
        [self sp_playerHideControlView];
    } else {
        [self sp_playerShowControlView];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGRect rect = [self thumbRect];
    CGPoint point = [touch locationInView:self.slider];
    if ([touch.view isKindOfClass:[UISlider class]]) { // 如果在滑块上点击就不响应pan手势
        if (point.x <= rect.origin.x + rect.size.width && point.x >= rect.origin.x) { return NO; }
    }
    return YES;
}

// 获取滑动条的bounds
- (CGRect)thumbRect {
    return [self.slider thumbRectForBounds:self.slider.bounds
                                                 trackRect:[self.slider trackRectForBounds:self.slider.bounds]
                                                     value:self.slider.value];
}

/**
 *  显示加载指示器
 */
- (void)showHUDWithTitle:(NSString *)title {
    if (!self.hud) {
        SPLoadingHUD *hud = [SPLoadingHUD showHUDWithTitle:title toView:self animated:YES];
        hud.activityIndicatorPosition = SPActivityIndicatorPositionLeft;
        hud.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        hud.bezelView.style = SPLoadingHUDBackgroundStyleSolidColor;
        hud.bezelView.appearance = SPLoadingHUDAppearanceCircle;
        hud.minSize = CGSizeMake(170, 30);
        hud.contentColor = [UIColor whiteColor];
        // 在SPVideoPlayerView中设置了它里面的手势处于一切controlView的子控件中均屏蔽,所以点击HUD时无法触发SPVideoPlayerView的手势，解决办法是设置hud.userInteractionEnabled = NO;
        // 还有一个解决办法是在SPVideoPlayerView的-(BOOL)gestureRecognizer:shouldReceiveTouch:代理方法中特别指定如果手势的view是SPLoadingHUD，返回YES，但是不建议此方法，因为这样增强了SPVideoPlayerView和controlView的耦合性，这次用的是SPLoadingHUD，下次换一个指示器，又得改.
        hud.userInteractionEnabled = NO;
        self.hud = hud;
    }
    
}

/**
 *  隐藏指示器
 */
- (void)hideHUD {
    [SPLoadingHUD hideHUDForView:self animated:YES];
    self.hud = nil;
}

@end

