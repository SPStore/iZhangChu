//
//  ZCSelectedWorksCell.m
//  iZhangChu
//
//  Created by Libo on 17/6/19.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCSelectedWorksCell.h"

@interface ZCSelectedWorksCell()
@property (weak, nonatomic) IBOutlet UIImageView *dishesImageView;
@property (weak, nonatomic) IBOutlet UIImageView *headerIconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *zanButton;

@end

@implementation ZCSelectedWorksCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
