//
//  ZCRecommendImageViewTitleCell.m
//  iZhangChu
//
//  Created by Libo on 17/4/24.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecommendImageViewTitleCell.h"
#import "ZCRecommendImageViewTitleModel.h"
#import "ZCRecommendWidgetItem.h"

@interface ZCRecommendImageViewTitleCell()
@property (nonatomic, strong) ZCRecommendImageViewTitleView *imageTitleView;
@property (nonatomic, strong) UIView *containerView;
@end

@implementation ZCRecommendImageViewTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.containerView];
    }
    return self;
}

- (void)setModel:(ZCRecommendBasicModel *)model {
    [super setModel:model];
    self.title = model.title;
    
    NSMutableArray *imageItems = @[].mutableCopy;
    NSMutableArray *titleItems = @[].mutableCopy;
    NSMutableArray *descItems  = @[].mutableCopy;
    
    for (ZCRecommendWidgetItem *item in model.widget_data) {
        if (item.id % 3 == 1) {
            [imageItems addObject:item];
        } else if (item.id % 3 == 2) {
            [titleItems addObject:item];
        } else {
            [descItems addObject:item];
        }
    }
    
    while (self.containerView.subviews.count < model.widget_data.count/3) {
        NSInteger count = self.containerView.subviews.count;
        
        if (imageItems.count > count && titleItems.count > count && descItems.count > count) {
            ZCRecommendWidgetItem *imageItem = imageItems[count];
            ZCRecommendWidgetItem *titleItem = titleItems[count];
            ZCRecommendWidgetItem *descItem = descItems[count];
            
            ZCRecommendImageViewTitleView *imageTitleView = [[ZCRecommendImageViewTitleView alloc] init];
            imageTitleView.translatesAutoresizingMaskIntoConstraints = NO;
            imageTitleView.imageItem = imageItem;
            imageTitleView.titleItem = titleItem;
            imageTitleView.descItem = descItem;
            [self.containerView addSubview:imageTitleView];
        }
    }
    
    // 这个for循环是避免cell的复用，在这里可以不需要这样的for循环，因为每个这种类型的cell上的子控件都是相同的
    for (int i = 0; i < self.containerView.subviews.count; i++) {
        ZCRecommendImageViewTitleView *imageTitleView = self.containerView.subviews[i];
        if (i < model.widget_data.count) {
            imageTitleView.hidden = NO;
        } else {
            imageTitleView.hidden = YES;
        }
    }
    
    ZCRecommendImageViewTitleModel *imageTitleModel = (ZCRecommendImageViewTitleModel *)model;
    imageTitleModel.cellHeight = 200 * self.containerView.subviews.count;
}

- (UIView *)containerView {
    
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        
    }
    return _containerView;
}

- (void)updateConstraints {
    [self.containerView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.top.equalTo(kTitleHeight);
    }];
    
    if (self.containerView.subviews.count > 1) {
        [self.containerView.subviews makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
        }];
        
        [self.containerView.subviews mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:10 leadSpacing:0 tailSpacing:0];
    }

    [super updateConstraints];
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}



@end

#import <UIImageView+WebCache.h>

@interface ZCRecommendImageViewTitleView()
@property (nonatomic, strong) UIImageView *photoView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation ZCRecommendImageViewTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.photoView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.descLabel];
    }
    return self;
}

- (void)setImageItem:(ZCRecommendWidgetItem *)imageItem {
    _imageItem = imageItem;
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:imageItem.content] placeholderImage:nil];
}

- (void)setTitleItem:(ZCRecommendWidgetItem *)titleItem {
    _titleItem = titleItem;
    self.titleLabel.text = titleItem.content;
}

- (void)setDescItem:(ZCRecommendWidgetItem *)descItem {
    _descItem = descItem;
    self.descLabel.text = descItem.content;
}

- (UILabel *)descLabel {
    
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.textAlignment = NSTextAlignmentCenter;
        _descLabel.font = [UIFont systemFontOfSize:13];
        _descLabel.alpha = 0.5;
        _descLabel.numberOfLines = 2;
    }
    return _descLabel;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.alpha = 0.8;
    }
    return _titleLabel;
}


- (UIImageView *)photoView {
    
    if (!_photoView) {
        _photoView = [[UIImageView alloc] init];
        
    }
    return _photoView;
}

- (void)updateConstraints {
    [self.photoView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(0);
        make.bottom.equalTo(self.titleLabel.top).offset(-5);
}];
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.top.equalTo(self.photoView.bottom).offset(5);
        make.bottom.equalTo(self.descLabel.top).offset(-5);
    }];
    
    [self.descLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.top.equalTo(self.titleLabel.bottom).offset(5);
        make.bottom.equalTo(-20);
    }];
    
    [super updateConstraints];
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}


@end
