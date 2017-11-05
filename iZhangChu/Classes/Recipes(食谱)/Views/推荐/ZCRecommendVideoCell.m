//
//  ZCRecommendVideoCell.m
//  iZhangChu
//
//  Created by Shengping on 17/4/21.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecommendVideoCell.h"
#import "ZCRecommendVideoModel.h"
#import <UIImageView+WebCache.h>

#define itemTypeIs(string) [item.type isEqualToString:string]

@interface ZCRecommendVideoCell()
@property (nonatomic, strong) UIView *videoBigView;
@end

@implementation ZCRecommendVideoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.videoBigView];
    }
    return self;
}

- (void)setModel:(ZCRecommendBasicModel *)model {
    [super setModel:model];
    
    self.title = model.title;
    
    NSMutableArray *imageItems = @[].mutableCopy;
    NSMutableArray *textItems = @[].mutableCopy;
    NSMutableArray *videoItems = @[].mutableCopy;
    NSMutableArray *descItems = @[].mutableCopy;
    
    // 每四个ZCRecommendWidgetItem对应一个ZCRecommendVideoItemView
    for (ZCRecommendWidgetItem *item in model.widget_data) {
        if (itemTypeIs(@"image")) {
            [imageItems addObject:item];
        } else if (itemTypeIs(@"text")) {
            if (item.id % 2 != 0) { // 如果id为奇数
                [textItems addObject:item];
            } else { // id为偶数
                [descItems addObject:item];
            }
        } else if (itemTypeIs(@"video")) {
            [videoItems addObject:item];
        }
    }
    
    // 固定三张图片
    // 不要用for循环，否则每走一次该方法，就会创建一次控件
    // self.videoBigView.subviews.count不要在循环体外部用变量抽离出来，因为它总是在变化
    while (self.videoBigView.subviews.count < kImageViewCount) {
        NSInteger count = self.videoBigView.subviews.count;
        if (imageItems.count >= kImageViewCount && textItems.count >= kImageViewCount && videoItems.count >= kImageViewCount && descItems.count >= kImageViewCount) {
            ZCRecommendWidgetItem *imageItem = imageItems[count];
            ZCRecommendWidgetItem *textItem = textItems[count];
            ZCRecommendWidgetItem *videoItem = videoItems[count];
            ZCRecommendWidgetItem *descItem = descItems[count];
            
            if (model.widget_data.count >= kImageViewCount) {
                ZCRecommendVideoItemView *videoItemView = [[ZCRecommendVideoItemView alloc] init];
                videoItemView.translatesAutoresizingMaskIntoConstraints = NO;
                videoItemView.imageItem = imageItem;
                videoItemView.textItem = textItem;
                videoItemView.videoItem = videoItem;
                videoItemView.descItem = descItem;
                [self.videoBigView addSubview:videoItemView];
                // 添加手势
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPlayImageView:)];
                [videoItemView addGestureRecognizer:tap];
            }
        }
    }
    
    // 这个for循环是避免cell的复用，在这里可以不需要这样的for循环，因为每个这种类型的cell上的子控件都是相同的
    for (int i = 0; i < self.subviews.count; i++) {
        ZCRecommendVideoItemView *videoItemView = self.subviews[i];
        if (i < model.widget_data.count) {
            videoItemView.hidden = NO;
        } else {
            videoItemView.hidden = YES;
        }
    }
    
    [self layoutSubControls];
  
}

- (void)tapPlayImageView:(UITapGestureRecognizer *)tap {
    
    ZCRecommendVideoItemView *itemView = (ZCRecommendVideoItemView *)tap.view;
    if ([self.delegate respondsToSelector:@selector(recommendVideoCellVideoItemViewClicked:)]) {
        // 跳转到下一级界面需要参数 dishes_id,只有imageItem中的link含有有
        [self.delegate recommendVideoCellVideoItemViewClicked:itemView.imageItem];
    }
}

- (UIView *)videoBigView {
    if (!_videoBigView) {
        _videoBigView = [[UIView alloc] init];
        _videoBigView.backgroundColor = [UIColor whiteColor];
    }
    return _videoBigView;
}

- (void)layoutSubControls {
    [self.videoBigView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.bottom.equalTo(0);  
        if (self.title.length) {
            make.top.equalTo(kTitleHeight);
        } else {
            make.top.equalTo(0);
        }
    }];
    
    if (self.videoBigView.subviews.count > 1) {
        [self.videoBigView.subviews makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(0);
        }];
        
        [self.videoBigView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0.5 leadSpacing:0.0 tailSpacing:0.0];
    }
    
}

@end

#import "ZCPlayImageView.h"

@interface ZCRecommendVideoItemView()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@end


@implementation ZCRecommendVideoItemView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.playImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.descLabel];
        
        [self layoutSubContrls];
  
    }
    return self;
}


- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.numberOfLines = 2;
        _descLabel.font = kDescFont;
        _descLabel.alpha = 0.5;
    }
    return _descLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = kTitleFont;
        _titleLabel.alpha = 0.8;
    }
    return _titleLabel;
}

- (ZCPlayImageView *)playImageView {
    
    if (!_playImageView) {
        _playImageView = [[ZCPlayImageView alloc] init];
        _playImageView.clipsToBounds = YES;
        _playImageView.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    return _playImageView;
}


- (void)setImageItem:(ZCRecommendWidgetItem *)imageItem {
    _imageItem = imageItem;
    [self.playImageView sd_setImageWithURL:[NSURL URLWithString:imageItem.content] placeholderImage:nil];
}

- (void)setTextItem:(ZCRecommendWidgetItem *)textItem {
    _textItem = textItem;
    self.titleLabel.text = textItem.content;
}

- (void)setVideoItem:(ZCRecommendWidgetItem *)videoItem {
    _videoItem = videoItem;
    self.playImageView.videoItem = videoItem;
    self.playImageView.imageItem = self.imageItem;
    self.playImageView.videoUrlString = videoItem.content;
    self.playImageView.title = self.textItem.content;
}

- (void)setDescItem:(ZCRecommendWidgetItem *)descItem {
    _descItem = descItem;
    self.descLabel.text = descItem.content;
}

- (void)layoutSubContrls {
    [self.playImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0);
        make.height.equalTo(kImageViewW);
    }];
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kLeftMargin);
        make.right.equalTo(-kRightMargin);
        make.top.equalTo(self.playImageView.bottom).offset(kTopMargin);
        make.bottom.equalTo(self.descLabel.top).offset(-kBottomMargin);
    }];
    [self.descLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.bottom).offset(kTopMargin);
    }];
    
}

@end





