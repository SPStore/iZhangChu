//
//  ZCLohasHomeCollectionViewCell.m
//  iZhangChu
//
//  Created by Libo on 17/5/13.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCLohasHomeCollectionViewCell.h"
#import "ZCLohasLogoModel.h"
#import "ZCMacro.h"
#import <UIImageView+WebCache.h>

@interface ZCLohasHomeCollectionViewCell()
@property (nonatomic, strong) UIImageView *logoImageView;
@end

@implementation ZCLohasHomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        
        [self.contentView addSubview:self.logoImageView];
        
        [self.logoImageView makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(60);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}

- (void)setModel:(ZCLohasLogoModel *)model {
    _model = model;
    
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:model.album_logo] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.logoImageView.image = [image circleImage];
    }];
}

- (UIImageView *)logoImageView {
    
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] init];
        
    }
    return _logoImageView;
}


@end



