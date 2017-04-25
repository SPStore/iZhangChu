//
//  ZCCourseHeaderView.m
//  iZhangChu
//
//  Created by Libo on 17/4/25.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCCourseHeaderView.h"
#import "ZCCourseHeaderModel.h"
#import "ZCCourseEpisodeModel.h"
#import "ZCPlayImageView.h"
#import "SPButton.h"
#import <UIImageView+WebCache.h>
#import "ZCMacro.h"

#define kEpisodeButtonPadding 5.0f
#define kEpisodeButtonWH (kScreenW-40-7*kEpisodeButtonPadding)/8
#define kMaxCol 8

@interface ZCCourseHeaderView()
// 最顶部播放视频的imageView
@property (weak, nonatomic) IBOutlet ZCPlayImageView *videoImageView;
// 上课人数
@property (weak, nonatomic) IBOutlet UILabel *numbersOfPersonLabel;
// 收藏
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UILabel *videoTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *contentFoldingButton;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectEpisodeLabel;
@property (weak, nonatomic) IBOutlet SPButton *updateFoldingButton;
@property (weak, nonatomic) IBOutlet UIView *buttonContainerView;

@end

@implementation ZCCourseHeaderView

+ (instancetype)courseHeaderView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectEpisodeLabel.text = @"选集";
    
    self.updateFoldingButton.imagePosition = SPButtonImagePositionRight;
    self.updateFoldingButton.imageRatio = 0.2;
}

- (void)setHeaderModel:(ZCCourseHeaderModel *)headerModel {
    _headerModel = headerModel;
    [self.updateFoldingButton setImage:[UIImage imageNamed:@"expend_down"] forState:UIControlStateNormal];
    [self.updateFoldingButton setTitle:[NSString stringWithFormat:@"更新至第%zd集",headerModel.episode] forState:UIControlStateNormal];
    
    for (int i = 0; i < headerModel.data.count; i++) {
        ZCCourseEpisodeButton *episodeBtn = [[ZCCourseEpisodeButton alloc] init];
        episodeBtn.backgroundColor = ZCColorRGBA(245, 245, 245, 1);
        [episodeBtn setTitle:[NSString stringWithFormat:@"%zd",i+1] forState:UIControlStateNormal];
        [episodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        episodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.buttonContainerView addSubview:episodeBtn];
    }
    [self layoutSubControl];
}

- (void)layoutSubControl {
    
    __block int i = 0;
    [self.buttonContainerView.subviews makeConstraints:^(MASConstraintMaker *make) {
        NSInteger col = i % kMaxCol;
        NSInteger row = i / kMaxCol;
        make.top.equalTo(row * (kEpisodeButtonWH+kEpisodeButtonPadding));
        make.left.equalTo(col * (kEpisodeButtonWH+kEpisodeButtonPadding));
        make.size.equalTo(CGSizeMake(kEpisodeButtonWH, kEpisodeButtonWH));
        i++;
    }];
}


@end



@implementation ZCCourseEpisodeButton


@end













