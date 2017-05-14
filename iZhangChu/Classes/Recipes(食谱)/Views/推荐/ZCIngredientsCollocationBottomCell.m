//
//  ZCIngredientsCollocationBottomCell.m
//  iZhangChu
//
//  Created by Shengping on 17/5/10.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCIngredientsCollocationBottomCell.h"
#import "ZCPlayImageView.h"
#import "ZCMacro.h"
#import "ZCRecipesSearchResultModel.h"
#import <UIImageView+WebCache.h>

@interface ZCIngredientsCollocationBottomCell()
@property (nonatomic, strong) ZCPlayImageView *playImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation ZCIngredientsCollocationBottomCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.playImageView];
        [self.contentView addSubview:self.titleLabel];
        
        [self.playImageView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(0);
            make.bottom.equalTo(self.titleLabel.top).offset(-5);
        }];
        
        [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.top.equalTo(self.playImageView.bottom).offset(5);
            make.height.equalTo(20);
        }];
    }
    return self;
}

- (void)setModel:(ZCRecipesSearchResultModel *)model {
    _model = model;
    [self.playImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    self.titleLabel.text = model.title;
}

- (ZCPlayImageView *)playImageView {
    
    if (!_playImageView) {
        _playImageView = [[ZCPlayImageView alloc] init];
        
    }
    return _playImageView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.alpha = 0.8;
    }
    return _titleLabel;
}


@end
