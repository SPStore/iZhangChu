//
//  ZCRecommendBasicCell.m
//  iZhangChu
//
//  Created by Shengping on 17/4/20.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecommendBasicCell.h"
#import "ZCRecommendBasicModel.h"

@interface ZCRecommendBasicCell()
@property (nonatomic, strong) UIView *bigView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *moreImageView;
@end

@implementation ZCRecommendBasicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)tapTitleLabel:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(recommendTitleCellClickedWithModel:)]) {
        [self.delegate recommendTitleCellClickedWithModel:(ZCRecommendImageViewTitleModel *)self.model];
    }
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    
    self.titleLabel.text = title;
    
    UIView *backgroundView = UIView.new;
    backgroundView.backgroundColor = [UIColor whiteColor];
    
    if (title.length) {
        [self.contentView addSubview:self.bigView];
        [self layoutSubControl];
    }
}

- (UIView *)bigView {
    if (!_bigView) {
        _bigView = [[UIView alloc] init];
        [_bigView addSubview:self.titleLabel];
        [_bigView addSubview:self.moreImageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTitleLabel:)];
        [_bigView addGestureRecognizer:tap];
    }
    return _bigView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.alpha = 0.8;
        _titleLabel.userInteractionEnabled = YES;
        // 水平方向抗拉伸，紧抱
        [_titleLabel setContentHuggingPriority:998 forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _titleLabel;
}

- (UIImageView *)moreImageView {
    
    if (!_moreImageView) {
        _moreImageView = [[UIImageView alloc] init];
        _moreImageView.contentMode = UIViewContentModeScaleAspectFit;
        _moreImageView.image = [UIImage imageNamed:@"more_icon"];
        
    }
    return _moreImageView;
}

- (void)layoutSubControl {
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(0);
        make.right.equalTo(self.moreImageView.left).offset(-15);
    }];
    [self.moreImageView makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(20, 20));
        make.left.equalTo(self.titleLabel.right).offset(15);
        make.centerY.equalTo(self.bigView.centerY);
    }];
    // 父控件根据子控件布局
    [self.bigView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self.moreImageView);
        make.left.greaterThanOrEqualTo(10).priorityMedium();
        make.right.greaterThanOrEqualTo(10).priorityMedium();
        make.height.equalTo(kTitleHeight);
        make.centerX.equalTo(self.contentView.centerX);
        make.top.equalTo(0);
    }];
}


@end
