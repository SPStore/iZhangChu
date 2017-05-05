//
//  ZCRecommendImageVideoCell.m
//  iZhangChu
//
//  Created by Libo on 17/4/21.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecommendImageVideoCell.h"
#import "ZCRecommendImageVideoModel.h"

#define kMargin 0.5
#define kDescLabelH 40

@interface ZCRecommendImageVideoCell()
@property (nonatomic, strong) ZCRecommendWidgetItemImageView *leftImageView;
@property (nonatomic, strong) ZCRecommendImageVideoRightBigView *rightBigView;
@property (nonatomic, strong) UILabel *descLabel;
@end

@implementation ZCRecommendImageVideoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.leftImageView];
        [self.contentView addSubview:self.rightBigView];
        [self.contentView addSubview:self.descLabel];
    
    }
    return self;
}

- (void)setModel:(ZCRecommendBasicModel *)model {
    [super setModel:model];
    
    self.title = model.title;

    self.rightBigView.basicModel = model;
    self.descLabel.text = model.desc;

    for (int i = 0 ; i < model.widget_data.count; i++) {
        // 提取model.widget_data数组中的前4个模型(item)，因为前4个模型合起来才对应左边的imageView上的数据
        if (i < 3) {
             ZCRecommendWidgetItem *item = model.widget_data[i];
            self.leftImageView.item = item;
        } else {
            break;
        }
    }
}

- (ZCRecommendImageVideoRightBigView *)rightBigView {
    
    if (!_rightBigView) {
        _rightBigView = [[ZCRecommendImageVideoRightBigView alloc] init];
        _rightBigView.translatesAutoresizingMaskIntoConstraints = NO;
        
    }
    return _rightBigView;
}


- (ZCRecommendWidgetItemImageView *)leftImageView {
    
    if (!_leftImageView) {
        _leftImageView = [[ZCRecommendWidgetItemImageView alloc] init];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
        _leftImageView.clipsToBounds = YES;
    }
    return _leftImageView;
}

- (UILabel *)descLabel {
    
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.textColor = [UIColor grayColor];
        _descLabel.textAlignment = NSTextAlignmentCenter;
        _descLabel.font = [UIFont systemFontOfSize:13];
    }
    return _descLabel;
}

- (void)updateConstraints {
    [self.leftImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(kScreenW/3-kMargin);
        make.bottom.equalTo(self.descLabel.top);
        if (self.title.length) {
            make.top.equalTo(kTitleHeight);
        } else {
            make.top.equalTo(0);
        }
     
    }];
    
    [self.rightBigView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.right).offset(kMargin);
        make.right.equalTo(0);
        make.bottom.equalTo(self.leftImageView);
        if (self.title.length) {
            make.top.equalTo(kTitleHeight);
        } else {
            make.top.equalTo(0);
        }
    }];
    
    [self.descLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(kDescLabelH);
    }];
    
    [super updateConstraints];
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

@end

#import "ZCPlayImageView.h"

@interface ZCRecommendImageVideoRightBigView()
@property (nonatomic, strong) ZCPlayImageView *playImagView;
@end

@implementation ZCRecommendImageVideoRightBigView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        
    }
    return self;
}

- (void)setBasicModel:(ZCRecommendBasicModel *)basicModel {
    _basicModel = basicModel;
    
    NSMutableArray *imageItems = @[].mutableCopy;
    NSMutableArray *videoItems = @[].mutableCopy;
    
    for (int i = 0; i < basicModel.widget_data.count; i++) {
        if (i >= 3) {
            ZCRecommendWidgetItem *item = basicModel.widget_data[i];
            if ([item.type isEqualToString:@"image"]) {
                [imageItems addObject:item];
            } else {
                [videoItems addObject:item];
            }
        }
    }
    
    // 固定四张图片
    while (self.subviews.count < 4) {
        NSInteger count = self.subviews.count;
        if (videoItems.count >= count && imageItems.count >= count) {
            ZCPlayImageView *playImagView = [[ZCPlayImageView alloc] init];
            playImagView.contentMode = UIViewContentModeScaleAspectFill;
            playImagView.clipsToBounds = YES;
            playImagView.imageItem = imageItems[count];
            playImagView.videoItem = videoItems[count];
            [self addSubview:playImagView];
        }
    }
    
    // 这个for循环是避免cell的复用，在这里可以不需要这样的for循环，因为每个这种类型的cell上的子控件都是相同的
    for (int i = 0; i < self.subviews.count; i++) {
        ZCPlayImageView *playImagView = self.subviews[i];
        if (i < basicModel.widget_data.count) {
            playImagView.hidden = NO;
        } else {
            playImagView.hidden = YES;
        }
    }
}


- (void)updateConstraints {
   
    __block int i = 0;
    
    __block CGFloat imageViewW = (kScreenW / 3 * 2 - kMargin) * 0.5;
    __block CGFloat imageViewH = ((kCellHeight - kTitleHeight - kDescLabelH) - kMargin) * 0.5;
    
    [self.subviews makeConstraints:^(MASConstraintMaker *make) {
        NSInteger col = i % 2; // 第几列
        NSInteger row = i / 2; // 第几行
        
        make.width.equalTo(imageViewW);
        make.height.equalTo(imageViewH);
        make.left.equalTo(col * (imageViewW+kMargin));
        make.top.equalTo(row * (imageViewH+kMargin));
        i++;
    }];
    
    [super updateConstraints];
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

@end


