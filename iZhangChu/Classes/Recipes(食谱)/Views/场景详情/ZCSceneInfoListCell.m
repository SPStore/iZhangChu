//
//  ZCSceneInfoListCell.m
//  iZhangChu
//
//  Created by Libo on 17/5/11.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCSceneInfoListCell.h"
#import "ZCSceneInfoListModel.h"
#import "ZCPlayImageView.h"
#import <UIImageView+WebCache.h>
#import "ZCTagInfoModel.h"
#import "ZCMacro.h"

@interface ZCSceneInfoListCell()

@property (weak, nonatomic) IBOutlet ZCPlayImageView *playImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIView *buttonContainerView;
@end

@implementation ZCSceneInfoListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setModel:(ZCSceneInfoListModel *)model {
    _model = model;
    [self.playImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    self.titleLabel.text = model.dishes_name;
    self.descLabel.text = model.dishes_desc;
    
    while (self.buttonContainerView.subviews.count < model.tags_info.count) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitleColor:ZCGlobalColor forState:UIControlStateNormal];
        [self.buttonContainerView addSubview:button];
    }
    
    UIButton *lastBtn = nil;
    
    for (int i = 0; i < self.buttonContainerView.subviews.count; i++) {
        UIButton *button = self.buttonContainerView.subviews[i];
        
        if (i < model.tags_info.count) {
            ZCTagInfoModel *tagModel = model.tags_info[i];
            [button setTitle:tagModel.text forState:UIControlStateNormal];
            CGFloat btnW = [tagModel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 25) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.width + 10;
            [button remakeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(btnW);
     
                if (lastBtn) {
                    make.left.equalTo(lastBtn.right).offset(10);
                } else {
                    make.left.equalTo(0);
                }
                make.top.bottom.equalTo(0);
            }];
            
            // 强制布局，目的是让masonry立刻产生frame，否则下面的button.frame没有实际值的
            [self layoutIfNeeded];
            
            // 画圆角,不建议使用属性设置圆角
            [self drawRoundedRectWithButton:button];
            
            if (CGRectGetMaxX(button.frame)+10 + self.buttonContainerView.zc_x > kScreenW) {
                button.hidden = YES;
                button.layer.hidden = YES;
            } else {
                button.hidden = NO;
                button.layer.hidden = NO;
                
            }
            
        } else {
            button.hidden = YES;
        }
        lastBtn = button;
    }
}

- (IBAction)collectionButtonAction:(UIButton *)sender {
    
    
}

- (void)drawRoundedRectWithButton:(UIButton *)button {
    
    // 先移除被复用的按钮上的shapeLayer
    [button.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CAShapeLayer class]]) {
            [obj removeFromSuperlayer];
        }
    }];

    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:button.bounds cornerRadius:button.zc_height*0.5];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    button.layer.mask = layer;
    
    UIBezierPath *linePath = [UIBezierPath bezierPathWithCGPath:path.CGPath];
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.path = linePath.CGPath;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    lineLayer.strokeColor = ZCGlobalColor.CGColor;
    [button.layer addSublayer:lineLayer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
