//
//  ZCRecommendMasterListView.m
//  iZhangChu
//
//  Created by Shengping on 17/4/24.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecommendMasterListView.h"
#import <UIImageView+WebCache.h>
#import "ZCHeaderFile.h"

@interface ZCRecommendMasterListView()
@property (weak, nonatomic) IBOutlet UIImageView *headerIconView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *FansLabel;

@end

@implementation ZCRecommendMasterListView

+ (instancetype)masterListView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}


- (void)setIconItem:(ZCRecommendWidgetItem *)iconItem {
    _iconItem = iconItem;
    [self.headerIconView sd_setImageWithURL:[NSURL URLWithString:iconItem.content] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.headerIconView.image = [image circleImage];
    }];
}

- (void)setNickItem:(ZCRecommendWidgetItem *)nickItem {
    _nickItem = nickItem;
    self.nickNameLabel.text = nickItem.content;
}

- (void)setAccountItem:(ZCRecommendWidgetItem *)accountItem {
    _accountItem = accountItem;
    self.accountLabel.text = accountItem.content;
}

- (void)setFansItem:(ZCRecommendWidgetItem *)fansItem {
    _fansItem = fansItem;
    self.FansLabel.text = fansItem.content;
}

@end
