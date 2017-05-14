//
//  ZCSceneInfoHeaderView.m
//  iZhangChu
//
//  Created by Shengping on 17/5/11.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCSceneInfoHeaderView.h"
#import "ZCSceneInfoDataModel.h"
#import <UIImageView+WebCache.h>

@interface ZCSceneInfoHeaderView()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation ZCSceneInfoHeaderView

+ (instancetype)shareSceneInfoHeaderView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setModel:(ZCSceneInfoDataModel *)model {
    _model = model;
    [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:model.scene_background] placeholderImage:nil];
    self.titleLabel.text = [NSString stringWithFormat:@"%zd道菜",model.dish_count];
    self.descLabel.text = model.scene_desc;
}

@end
