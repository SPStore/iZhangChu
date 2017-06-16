//
//  ZCDishesInfoHeaderView.m
//  iZhangChu
//
//  Created by Libo on 17/6/9.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCDishesInfoHeaderView.h"
#import "ZCPlayImageView.h"
#import "SPButton.h"
#import "ZCDishesInfoModel.h"
#import "ZCTagInfoModel.h"
#import "ZCMacro.h"
#import <UIImageView+WebCache.h>

@interface ZCDishesInfoHeaderView ()
@property (weak, nonatomic) IBOutlet ZCPlayImageView *playImageView;
@property (weak, nonatomic) IBOutlet UIButton *IngredientsReadyButton;
@property (weak, nonatomic) IBOutlet UIButton *makeStepButton;
@property (weak, nonatomic) IBOutlet UIButton *downLoadButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *tagButtonView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagButtonViewConstraintH;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet SPButton *difficultyButton;
@property (weak, nonatomic) IBOutlet SPButton *cookTimeButton;
@property (weak, nonatomic) IBOutlet SPButton *tasteButton;
@property (weak, nonatomic) IBOutlet UIView *bottomButtonView;

@end

@implementation ZCDishesInfoHeaderView

+ (instancetype)sharedDishesInfoHeaderView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.difficultyButton.imagePosition = SPButtonImagePositionTop;
    self.difficultyButton.imageRatio = 0.5;
    self.cookTimeButton.imagePosition = SPButtonImagePositionTop;
    self.cookTimeButton.imageRatio = 0.5;
    self.tasteButton.imagePosition = SPButtonImagePositionTop;
    self.tasteButton.imageRatio = 0.5;
}

- (void)setModel:(ZCDishesInfoModel *)model {
    _model = model;
    [self.playImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    self.titleLabel.text = model.dishes_name;
    self.descLabel.text = model.material_desc;
    [self.difficultyButton setTitle:[NSString stringWithFormat:@"难度：%@",model.hard_level] forState:UIControlStateNormal];
    [self.cookTimeButton setTitle:[NSString stringWithFormat:@"烹饪时间：%@",model.cooke_time] forState:UIControlStateNormal];
    [self.tasteButton setTitle:[NSString stringWithFormat:@"口味：%@",model.taste] forState:UIControlStateNormal];

    CGFloat padding = 10;
    CGFloat buttonW = 0;
    CGFloat buttonH = 20;
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat lastButtonMaxX = 0;
    
    for (int i = 0; i < model.tags_info.count; i++) {
        ZCTagInfoModel *tagModel = model.tags_info[i];
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:tagModel.text forState:UIControlStateNormal];
        [button setTitleColor:ZCGlobalColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        button.alpha = 0.8;
        button.layer.borderWidth = 1;
        button.layer.borderColor = ZCGlobalColor.CGColor;
        button.layer.cornerRadius = buttonH*0.5;
        button.layer.masksToBounds = YES;
        [self.tagButtonView addSubview:button];
        
        buttonW = [button.titleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, buttonH) options:0 attributes:nil context:nil].size.width + 25;
        buttonX = lastButtonMaxX + padding;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        if (CGRectGetMaxX(button.frame) + padding > kScreenW) {
            buttonY = CGRectGetMaxY(button.frame) + padding*0.8;
            buttonX = padding;
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        }
        lastButtonMaxX = CGRectGetMaxX(button.frame);
        self.tagButtonViewConstraintH.constant = CGRectGetMaxY(button.frame);
    }
    [self layoutIfNeeded];
    self.zc_height = CGRectGetMaxY(self.bottomButtonView.frame);

}


@end
