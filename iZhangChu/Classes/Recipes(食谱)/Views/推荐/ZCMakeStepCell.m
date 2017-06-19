//
//  ZCMakeStepCell.m
//  iZhangChu
//
//  Created by Libo on 17/6/16.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCMakeStepCell.h"
#import <UIImageView+WebCache.h>
#import "ZCDishesMakeStepModel.h"

@interface ZCMakeStepCell()
@property (weak, nonatomic) IBOutlet UIImageView *stepImageView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation ZCMakeStepCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setModel:(ZCDishesMakeStepModel *)model {
    _model = model;
    [self.stepImageView sd_setImageWithURL:[NSURL URLWithString:model.dishes_step_image] placeholderImage:nil];
    
    NSString *descString = [NSString stringWithFormat:@"%@. %@",model.dishes_step_order,model.dishes_step_desc];
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:descString];
    [attString setAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} range:[descString rangeOfString:[NSString stringWithFormat:@"%@.",model.dishes_step_order]]];
    self.descLabel.attributedText = attString;
    
}

@end
