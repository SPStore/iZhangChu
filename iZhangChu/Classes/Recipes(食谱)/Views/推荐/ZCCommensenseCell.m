//
//  ZCCommensenseCell.m
//  iZhangChu
//
//  Created by Libo on 17/6/17.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCCommensenseCell.h"
#import "ZCDishesCommensenseModel.h"
#import <UIImageView+WebCache.h>

@interface ZCCommensenseCell()
@property (weak, nonatomic) IBOutlet UIImageView *dishesImageView;
@property (weak, nonatomic) IBOutlet UIView *myContentView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation ZCCommensenseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ZCDishesCommensenseModel *)model {
    
    _model = model;
    
    if (_indexPath.section == 0) {
        [self.dishesImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
        self.dishesImageView.hidden = NO;
        self.myContentView.hidden = YES;
    } else if (_indexPath.section == 1) {
        self.titleLabel.text = @"相关常识";
        self.contentLabel.text = model.nutrition_analysis;
        self.dishesImageView.hidden = YES;
        self.myContentView.hidden = NO;
    } else {
        self.titleLabel.text = @"制作指导";
        self.contentLabel.text = model.production_direction;
        self.dishesImageView.hidden = YES;
        self.myContentView.hidden = NO;
    }
    
}
@end
