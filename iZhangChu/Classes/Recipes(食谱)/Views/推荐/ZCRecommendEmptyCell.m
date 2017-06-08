//
//  ZCRecommendEmptyCell.m
//  iZhangChu
//
//  Created by Shengping on 17/4/24.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecommendEmptyCell.h"
#import "ZCRecommendEmptyModel.h"

@implementation ZCRecommendEmptyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = ZCBackgroundColor;
        
    }
    return self;
}

- (void)setModel:(ZCRecommendBasicModel *)model {
    [super setModel:model];
    self.titleViewW = 160;
    self.title = model.title;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
