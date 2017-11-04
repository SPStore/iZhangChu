//
//  ZCVideoViewController.m
//  iZhangChu
//
//  Created by Libo on 2017/11/3.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCVideoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ZCVideoControlView.h"
#import "SPVideoPlayer.h"
#import <Masonry.h>

@interface ZCVideoViewController () <SPVideoPlayerDelegate>
/** 播放器View的父视图*/
@property (strong, nonatomic)  UIView *playerFatherView;
@property (strong, nonatomic)  SPVideoPlayerView *playerView;
/** 离开页面时候是否在播放 */
@property (nonatomic, assign) BOOL isPlaying;
/** 播放模型数组 */
@property (nonatomic, strong) NSMutableArray<SPVideoItem *> *videoItems;

@end

@implementation ZCVideoViewController

- (void)dealloc {
    NSLog(@"%@释放了",self.class);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.view.backgroundColor = [UIColor blackColor];
    // pop回来时候是否自动播放
    if (self.navigationController.viewControllers.count == 2 && self.playerView && self.isPlaying) {
        self.isPlaying = NO;
        self.playerView.playerPushedOrPresented = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // push出下一级页面时候暂停
    if (self.navigationController.viewControllers.count == 3 && self.playerView && !self.playerView.isPauseByUser)
    {
        self.isPlaying = YES;
        self.playerView.playerPushedOrPresented = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.playerFatherView];
    [self.playerFatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    // 开始播放，默认不开始播放
    [self.playerView startPlay];
}

// 返回值要必须为NO
- (BOOL)shouldAutorotate {
    return NO;
}

// 下面2个方法强制横屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeRight;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)setVideoItem:(ZCRecommendWidgetItem *)videoItem {
    _videoItem = videoItem;
    NSArray *urls = [videoItem.content componentsSeparatedByString:@"#"];
    if (urls.count) {
        for (int i = 0; i < urls.count; i++) {
            NSString *urlString = urls[i];
            SPVideoItem *videoItem = [[SPVideoItem alloc] init];
            videoItem.videoURL = [NSURL URLWithString:urlString];
            videoItem.shouldAutorotate = NO;
            videoItem.fatherView = self.playerFatherView;
            [self.videoItems addObject:videoItem];
        }
    }
}

#pragma mark - Getter

- (UIView *)playerFatherView {
    
    if (!_playerFatherView) {
        _playerFatherView = [[UIView alloc] init];
        _playerFatherView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _playerFatherView;
}

- (SPVideoPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [[SPVideoPlayerView alloc] init];
        ZCVideoControlView *controlView = [ZCVideoControlView shareVideoControlView];
        [_playerView configureControlView:controlView videoItems:self.videoItems];
        
        _playerView.resumePlayFromLastStopPoint = NO;
        
        // 设置代理
        _playerView.delegate = self;
        
        // 打开下载功能（默认没有这个功能）
        _playerView.hasDownload    = YES;
        
        // 打开预览图,默认是打开的
        _playerView.requirePreviewView = YES;
        
    }
    return _playerView;
}

// 下面两个方法在播放多个视频时才有用
- (NSMutableArray *)videoItems {
    if (!_videoItems) {
        _videoItems = [NSMutableArray array];
    }
    return _videoItems;
}

#pragma mark - SPVideoPlayerDelegate

- (void)sp_playerBackAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
