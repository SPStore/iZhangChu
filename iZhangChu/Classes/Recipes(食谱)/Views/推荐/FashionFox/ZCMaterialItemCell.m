//
//  ZCMaterialItemCell.m
//  iZhangChu
//
//  Created by Libo on 17/6/17.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCMaterialItemCell.h"
#import "ZCDishesMaterialModel.h"

@interface ZCMaterialItemCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@end

@implementation ZCMaterialItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setMaterialItem:(ZCDishesMaterialItem *)materialItem {
    _materialItem = materialItem;
    self.titleLabel.text = materialItem.material_name;
    self.amountLabel.text = materialItem.material_weight;
}
@end
