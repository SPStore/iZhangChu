//
//  ZCMineHomeCell.m
//  iZhangChu
//
//  Created by Shengping on 17/5/13.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCMineHomeCell.h"
#import "ZCMacro.h"
#import "ZCMineBasicModel.h"

@interface ZCMineHomeCell()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, weak) CALayer *myLayer;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIImageView *arrowImageView;
@end

@implementation ZCMineHomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CALayer *layer = [CALayer layer];
        self.myLayer = layer;
        layer.frame = CGRectMake(15, 43.5, kScreenW-15, 0.5);
        layer.borderWidth = 0.5;
        layer.borderColor = [UIColor grayColor].CGColor;
        layer.opacity = 0.3;
        [self.contentView.layer addSublayer:layer];
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.rightImageView];
        [self.contentView addSubview:self.arrowImageView];
        
        [self layoutSubControls];
    }
    
    return self;
}

- (void)setModel:(ZCMineBasicModel *)model {
    _model = model;
    
    self.titleLabel.text = model.title;
    self.rightImageView.image = [UIImage imageNamed:model.rightImage];
    if (model.showArrow) {
        self.arrowImageView.hidden = NO;
    } else {
        self.arrowImageView.hidden = YES;
    }
}

- (void)setupSingleLineWithIndexPath:(NSIndexPath *)indexPath
                   rowCountInSection:(NSInteger)rowCount
                        sectionCount:(NSInteger)sectionCount {
    if (rowCount == 1 || indexPath.row == rowCount - 1) {
        self.myLayer.hidden = YES;
    } else {
        self.myLayer.hidden = NO;
    }
}

- (UIImageView *)arrowImageView {
    
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@"ArrowRight"];

    }
    return _arrowImageView;
}


- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];

        
    }
    return _rightImageView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.alpha = 0.8;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        
    }
    return _titleLabel;
}

- (void)layoutSubControls {
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(self);
        make.width.equalTo(100);
    }];
    
    [self.rightImageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-40);
        make.centerY.equalTo(self);
        make.width.equalTo(140/(90/40));
        make.height.equalTo(40);
    }];
    
    [self.arrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-15);
        make.width.equalTo(6);
        make.height.equalTo(54*6/24);
        make.centerY.equalTo(self);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
