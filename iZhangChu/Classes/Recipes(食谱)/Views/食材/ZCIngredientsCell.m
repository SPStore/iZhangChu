//
//  ZCIngredientsCell.m
//  iZhangChu
//
//  Created by Shengping on 17/4/24.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCIngredientsCell.h"
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
#import "ZCIngredientsModel.h"

@interface ZCIngredientsCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *firstImageView;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@end

@implementation ZCIngredientsCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.firstImageView];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)setModel:(ZCIngredientsDataModel *)dataModel indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self.firstImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.image] placeholderImage:nil];
        self.titleLabel.hidden = YES;
        self.firstImageView.hidden = NO;
    } else {
        ZCIngredientsModel *model = dataModel.data[indexPath.row-1];
        self.titleLabel.text = model.text;
        self.titleLabel.hidden = NO;
        self.firstImageView.hidden = YES;
    }
}

- (NSMutableArray *)buttonArray {
    
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
        
    }
    return _buttonArray;
}


- (UIImageView *)firstImageView {
    if (!_firstImageView) {
        _firstImageView = [[UIImageView alloc] init];
        _firstImageView.backgroundColor = ZCBackgroundColor;
    }
    return _firstImageView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor colorWithWhite:0 alpha:0.6];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        _titleLabel.backgroundColor = ZCBackgroundColor;
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
    self.firstImageView.frame = self.bounds;
}


@end





