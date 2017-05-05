//
//  ZCRecommendBasicCell.m
//  iZhangChu
//
//  Created by Libo on 17/4/20.
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
        _titleViewW = 115;
    }
    return self;
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
    [self.bigView makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_titleViewW);
        make.height.equalTo(kTitleHeight);
        make.centerX.equalTo(self.contentView.centerX);
        make.top.equalTo(0);
    }];
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(0);
        make.right.equalTo(self.moreImageView.left).offset(-15);
    }];
    [self.moreImageView makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(20, 20));
        make.left.equalTo(self.titleLabel.right).offset(15);
        make.right.equalTo(0);
        make.centerY.equalTo(self.bigView.centerY);
    }];
}


@end
