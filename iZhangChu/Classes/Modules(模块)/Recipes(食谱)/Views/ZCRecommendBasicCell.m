//
//  ZCRecommendBasicCell.m
//  iZhangChu
//
//  Created by Libo on 17/4/20.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecommendBasicCell.h"
#import "ZCRecommendBasicModel.h"
#import "ZCRecommendLikeModel.h"
@implementation ZCRecommendBasicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
- (void)setModel:(ZCRecommendBasicModel *)model {
    _model = model;
    for (ZCRecommendLikeItem  *item in model.widget_data) {
        NSLog(@"++++%@",item.content);
        if ([item.type isEqualToString:@"image"]) { // image类型
        } else { // text类型
        }
    }
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
