//
//  ZCRecipesSearchResultCell.m
//  iZhangChu
//
//  Created by Libo on 17/4/29.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecipesSearchResultCell.h"
#import <UIImageView+WebCache.h>
#import "ZCRecipesSearchResultModel.h"
#import "ZCPlayImageView.h"
#import "ZCMacro.h"

@interface ZCRecipesSearchResultCell()

@property (weak, nonatomic) IBOutlet ZCPlayImageView *dishPlayImageView;
@property (weak, nonatomic) IBOutlet UIView *rightContainerView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *difficultyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *tasteLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tasteImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *timeImageView;

@end

@implementation ZCRecipesSearchResultCell

- (void)setModel:(ZCRecipesSearchResultModel *)model {
    _model = model;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.dishPlayImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    
    // 给标题和描述内容中与搜索关键字相同的字符赋予颜色
    NSMutableAttributedString *mutableTitle = [[NSMutableAttributedString alloc] initWithString:model.title];
    [mutableTitle addAttribute:NSForegroundColorAttributeName value:ZCGlobalColor range:[model.title rangeOfString:self.keyword]];
    self.titleLabel.attributedText = mutableTitle;
    
    NSMutableAttributedString *mutableDesc = [[NSMutableAttributedString alloc] initWithString:model.desc];
    [mutableDesc addAttribute:NSForegroundColorAttributeName value:ZCGlobalColor range:[model.desc rangeOfString:self.keyword]];
    self.descLabel.attributedText = mutableDesc;
    
    self.difficultyLabel.text = [@"难度:" stringByAppendingString:model.hard_level];
    self.tasteLabel.text = [@"味道:" stringByAppendingString:model.taste];
    self.timeLabel.text = [@"烹饪时间:" stringByAppendingString:model.cooking_time];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.dishPlayImageView.playButtonPosition = ZCPlayImageViewPlayButtonPositionRightBottom;
    self.dishPlayImageView.clickBlock = ^(UITapGestureRecognizer *tap) {
        // do something
        NSLog(@"点击了imageView");
    };
    
    self.headImageView.image = [UIImage imageNamed:@"难易度"];
    self.tasteImageView.image = [UIImage imageNamed:@"口味"];
    self.timeImageView.image = [UIImage imageNamed:@"时长"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRightView:)];
    [self.rightContainerView addGestureRecognizer:tap];
}

- (void)tapRightView:(UITapGestureRecognizer *)sender {
    // do somthing
    NSLog(@"点击了rightView");
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
