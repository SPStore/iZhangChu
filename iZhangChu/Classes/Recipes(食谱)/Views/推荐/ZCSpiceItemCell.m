//
//  ZCSpiceItemCell.m
//  iZhangChu
//
//  Created by Libo on 17/6/17.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCSpiceItemCell.h"
#import "ZCDishesMaterialModel.h"
#import <UIImageView+WebCache.h>

@interface ZCSpiceItemCell()
@property (weak, nonatomic) IBOutlet UIImageView *materialImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ZCSpiceItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSpiceItem:(ZCDishesSpiceItem *)spiceItem {
    _spiceItem = spiceItem;
    [self.materialImageView sd_setImageWithURL:[NSURL URLWithString:spiceItem.image] placeholderImage:nil];
    self.titleLabel.text = spiceItem.title;
}


@end
