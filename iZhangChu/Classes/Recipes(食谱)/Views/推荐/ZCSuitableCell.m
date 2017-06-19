//
//  ZCSuitableCell.m
//  iZhangChu
//
//  Created by Libo on 17/6/17.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCSuitableCell.h"
#import "ZCDishesSuitableModel.h"
#import <UIImageView+WebCache.h>

@interface ZCSuitableCell()
@property (weak, nonatomic) IBOutlet UIImageView *dishesImageView;
@property (weak, nonatomic) IBOutlet UIView *myContentView;
@property (weak, nonatomic) IBOutlet UIImageView *suitableImageView;
@property (weak, nonatomic) IBOutlet UILabel *suitableTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *suitableDescLabel;
@end

@implementation ZCSuitableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setModel:(ZCDishesSuitableModel *)model {
    _model = model;
    
    [self.dishesImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    self.dishesImageView.hidden = NO;
    self.myContentView.hidden = YES;
    
}

- (void)setItem:(ZCDishesSuitableItem *)item {
    [self.suitableImageView sd_setImageWithURL:[NSURL URLWithString:item.image] placeholderImage:nil];
    self.suitableTitleLabel.text = item.material_name;
    self.suitableDescLabel.text = item.suitable_desc;
    self.dishesImageView.hidden = YES;
    self.myContentView.hidden = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
