//
//  ZCRecommendHaveHeaderIconImageView.m
//  iZhangChu
//
//  Created by Libo on 17/4/24.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecommendHaveHeaderIconImageView.h"
#import <UIImageView+WebCache.h>
#import "ZCHeaderFile.h"

@interface ZCRecommendHaveHeaderIconImageView()
@property (weak, nonatomic) IBOutlet UIImageView *foodImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;

@end

@implementation ZCRecommendHaveHeaderIconImageView

+ (instancetype)haveHeaderIconImageView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (void)setImageItem:(ZCRecommendWidgetItem *)imageItem {
    _imageItem = imageItem;
    [self.foodImageView sd_setImageWithURL:[NSURL URLWithString:imageItem.content] placeholderImage:nil];
}

- (void)setIconItem:(ZCRecommendWidgetItem *)iconItem {
    _iconItem = iconItem;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:iconItem.content] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.iconView.image = [image circleImage];
    }];
}

- (void)setNickItem:(ZCRecommendWidgetItem *)nickItem {
    _nickItem = nickItem;
    self.nickLabel.text = nickItem.content;
}

@end
