//
//  ZCPlayImageView.m
//  iZhangChu
//
//  Created by Libo on 17/4/21.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCPlayImageView.h"
#import <UIImageView+WebCache.h>

@interface ZCPlayImageView()
@property (nonatomic, weak) UIButton *playButton;

@end

@implementation ZCPlayImageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubControl];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self addSubControl];
    }
    return self;
}

- (void)setImageItem:(ZCRecommendWidgetItem *)imageItem {
    _imageItem = imageItem;
    [self sd_setImageWithURL:[NSURL URLWithString:imageItem.content] placeholderImage:nil];
}

- (void)setVideoItem:(ZCRecommendWidgetItem *)videoItem {
    _videoItem = videoItem;
}

- (void)addSubControl {
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playButton = playButton;
    [playButton setImage:[UIImage imageNamed:@"play-A"] forState:UIControlStateNormal];
    [self addSubview:playButton];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat w = self.frame.size.width*0.25;
    CGFloat h = w;
    CGRect frame = self.playButton.frame;
    frame.size = CGSizeMake(w, h);
    self.playButton.frame = frame;
    self.playButton.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
}

@end







