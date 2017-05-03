//
//  ZCRecipesAutoSearchTopListCell.m
//  iZhangChu
//
//  Created by Libo on 17/5/2.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecipesAutoSearchTopListCell.h"
#import "ZCRecipesAutoSearchModel.h"
#import "ZCPlayImageView.h"
#import <UIImageView+WebCache.h>

@interface ZCRecipesAutoSearchTopListCell()
@property (weak, nonatomic) IBOutlet ZCPlayImageView *playImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ZCRecipesAutoSearchTopListCell

- (void)setModel:(NSObject *)model {
    [super setModel:model];
    ZCRecipesAutoSearchTopListModel *topListModel = (ZCRecipesAutoSearchTopListModel *)model;
    [self.playImageView sd_setImageWithURL:[NSURL URLWithString:topListModel.image] placeholderImage:nil];
    self.titleLabel.text = topListModel.title;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.playImageView.playButtonPosition = ZCPlayImageViewPlayButtonPositionRightBottom;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
