//
//  ZCRecommendHaveHeaderIconImageCell.m
//  iZhangChu
//
//  Created by Shengping on 17/4/24.
//  Copyright © 2017年 iDress. All rights reserved.
//  含有头像的image的cell

#import "ZCRecommendHaveHeaderIconImageCell.h"
#import "ZCRecommendHaveHeaderIconImageModel.h"
#import "ZCRecommendWidgetItem.h"
#import "ZCRecommendHaveHeaderIconImageView.h"

@interface ZCRecommendHaveHeaderIconImageCell()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *descLabel;
@end

@implementation ZCRecommendHaveHeaderIconImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.containerView];
        [self.contentView addSubview:self.descLabel];
    }
    return self;
}

- (void)setModel:(ZCRecommendBasicModel *)model {
    [super setModel:model];
    
    self.title = model.title;
    self.descLabel.text = model.desc;
    
    NSMutableArray *imgItems = @[].mutableCopy;
    NSMutableArray *iconItems = @[].mutableCopy;
    NSMutableArray *nickItems = @[].mutableCopy;
    
    for (ZCRecommendWidgetItem *item in model.widget_data) {
        if (item.id % 3 == 1) {
            [imgItems addObject:item];
        } else if (item.id % 3 == 2) {
            [iconItems addObject:item];
        } else {
            [nickItems addObject:item];
        }
    }
    
    while (self.containerView.subviews.count < model.widget_data.count/3) {
        NSInteger count = self.containerView.subviews.count;
        if (imgItems.count >= count && iconItems.count >= count && nickItems.count >= count) {
            ZCRecommendWidgetItem *imgItem = imgItems[count];
            ZCRecommendWidgetItem *iconItem = iconItems[count];
            ZCRecommendWidgetItem *nickItem = nickItems[count];
            
            ZCRecommendHaveHeaderIconImageView *iconImageView = [ZCRecommendHaveHeaderIconImageView haveHeaderIconImageView];
            iconImageView.imageItem = imgItem;
            iconImageView.iconItem = iconItem;
            iconImageView.nickItem = nickItem;
            [self.containerView addSubview:iconImageView];
        }
 
    }
    
    // 这个for循环是避免cell的复用，在这里可以不需要这样的for循环，因为每个这种类型的cell上的子控件都是相同的
    for (int i = 0; i < self.containerView.subviews.count; i++) {
        ZCRecommendHaveHeaderIconImageView *iconImageView = self.containerView.subviews[i];
        if (i < model.widget_data.count) {
            iconImageView.hidden = NO;
        } else {
            iconImageView.hidden = YES;
        }
    }
    
    [self layoutSubControls];
}

- (UILabel *)descLabel {
    
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.textColor = [UIColor grayColor];
        _descLabel.textAlignment = NSTextAlignmentCenter;
        _descLabel.font = [UIFont systemFontOfSize:13];
    }
    return _descLabel;
}

- (UIView *)containerView {
    
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        
    }
    return _containerView;
}

- (void)layoutSubControls {
    [self.containerView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.bottom.equalTo(self.descLabel.top).offset(-5);
        make.top.equalTo(kTitleHeight);
    }];
    
    if (self.containerView.subviews.count > 1) {
        [self.containerView.subviews makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(0);
        }];
        
        [self.containerView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0.5 leadSpacing:0 tailSpacing:0];
    }
    
    [self.descLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(40);
    }];
    
}


@end
