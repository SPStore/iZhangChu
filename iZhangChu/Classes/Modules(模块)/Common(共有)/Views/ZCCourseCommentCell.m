//
//  ZCCourseCommentCell.m
//  iZhangChu
//
//  Created by Libo on 17/4/27.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCCourseCommentCell.h"
#import <UIImageView+WebCache.h>
#import "ZCHeaderFile.h"

@interface ZCCourseCommentCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImagView;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation ZCCourseCommentCell

- (void)setComment:(ZCCourseComment *)comment {
    _comment = comment;
    
    [self.headImagView sd_setImageWithURL:[NSURL URLWithString:comment.head_img] placeholderImage:[UIImage imageNamed:@"userHeadImage"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.headImagView.image = [image circleImage];
    }];
    
    self.nickLabel.text = comment.nick;
    self.contentLabel.text = comment.content;
    self.timeLabel.text = comment.create_time;
    
    
    [self layoutIfNeeded];
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
