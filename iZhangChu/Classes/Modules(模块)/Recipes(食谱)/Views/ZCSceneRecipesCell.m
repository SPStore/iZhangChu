//
//  ZCSceneRecipesCell.m
//  iZhangChu
//
//  Created by Libo on 17/5/3.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCSceneRecipesCell.h"
#import "ZCSceneRecipesModel.h"
#import <UIImageView+WebCache.h>

@interface ZCSceneRecipesCell()
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation ZCSceneRecipesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.logoImageView.image = [UIImage imageNamed:@"AllScreenList"];
}

- (void)setModel:(ZCSceneRecipesModel *)model {
    _model = model;
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.scene_background] placeholderImage:nil];
    self.logoImageView.hidden = !model.is_new;
    self.titleLabel.text = model.scene_title;
    self.countLabel.text = [NSString stringWithFormat:@"%zd道菜",model.dish_count];
}

@end
