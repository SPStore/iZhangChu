//
//  ZCIngredientsCollocationCell.m
//  iZhangChu
//
//  Created by Libo on 17/5/9.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCIngredientsCollocationCell.h"
#import "ZCIngredientsButtonModel.h"
#import "ZCMacro.h"
#import <UIImageView+WebCache.h>

@interface ZCIngredientsCollocationCell()
@property (nonatomic, strong) UIImageView *dishImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *coverView;
@end

@implementation ZCIngredientsCollocationCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.dishImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.coverView];
        
    }
    return self;
}

- (void)setButtonModel:(ZCIngredientsButtonModel *)buttonModel {
    _buttonModel = buttonModel;
    [self.dishImageView sd_setImageWithURL:[NSURL URLWithString:buttonModel.image] placeholderImage:nil];
    self.titleLabel.text = buttonModel.text;
    
    self.coverView.hidden = !buttonModel.selected;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];

}

- (void)tapCoverView:(UITapGestureRecognizer *)tap {
    self.coverView.hidden = !self.coverView.hidden;

}


#pragma mark - lazy
- (UIImageView *)dishImageView {
    
    if (!_dishImageView) {
        _dishImageView = [[UIImageView alloc] init];
        _dishImageView.contentMode = UIViewContentModeScaleAspectFill;
        _dishImageView.layer.masksToBounds = YES;
        
    }
    return _dishImageView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.alpha = 0.8;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIImageView *)coverView {
    
    if (!_coverView) {
        _coverView = [[UIImageView alloc] init];
        _coverView.image = [UIImage imageNamed:@"materialSelected"];
        _coverView.hidden = YES;
    }
    return _coverView;
}


- (void)updateConstraints {
    [self.dishImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0);
        make.bottom.equalTo(self.titleLabel.top).offset(-5);
    }];
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.top.equalTo(self.dishImageView.bottom).offset(5);
        make.height.equalTo(20);
    }];
    
    [self.coverView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.dishImageView);
    }];
    [super updateConstraints];
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}


@end
