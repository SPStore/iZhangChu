//
//  ZCLohasHomeTableViewCell.m
//  iZhangChu
//
//  Created by Libo on 17/5/13.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCLohasHomeTableViewCell.h"
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
#import "ZCLohasListModel.h"
#import "ZCMacro.h"

@interface ZCLohasHomeTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *dishImageView;
@property (weak, nonatomic) IBOutlet UIButton *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *logoTitleLabel;

@end

@implementation ZCLohasHomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setModel:(ZCLohasListDataModel *)model {
    _model = model;
    [self.dishImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:model.album_logo] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [self.logoImageView setImage:[image circleImage] forState:UIControlStateNormal];
    }];
    
    
    self.titleLabel.text = [model.series_name componentsSeparatedByString:@"#"][2];
    self.updateLabel.text = [NSString stringWithFormat:@"更新至%zd集",model.episode];
    self.countLabel.text = [NSString stringWithFormat:@"上课人数%zd",model.play];
    self.logoTitleLabel.text = model.album;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
