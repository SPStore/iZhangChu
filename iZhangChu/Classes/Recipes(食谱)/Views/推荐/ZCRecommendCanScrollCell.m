//
//  ZCRecommendLuckyMoneyEnterCell.m
//  iZhangChu
//
//  Created by Shengping on 17/4/20.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecommendCanScrollCell.h"
#import "ZCRecommendCanScrollModel.h"
#import "ZCRecommendWidgetItem.h"

#define kImageViewW 160

@interface ZCRecommendCanScrollCell()
@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UIView *myContentView;
@end

@implementation ZCRecommendCanScrollCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.scrollview];
    }
    return self;
}

- (void)setModel:(ZCRecommendBasicModel *)model {
    [super setModel:model];
    
    NSInteger count = model.widget_data.count;
    for (int i = 0; i < count; i++) {
        ZCRecommendWidgetItem *item = model.widget_data[i];
        
        ZCRecommendWidgetItemImageView *imageview = [[ZCRecommendWidgetItemImageView alloc] init];
        imageview.translatesAutoresizingMaskIntoConstraints = NO;
        imageview.showMaskView = NO;
        imageview.item = item;
        [self.myContentView addSubview:imageview];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageview addGestureRecognizer:tap];
    }
    
    [self layoutSubControls];
}

- (void)tapImageView:(UITapGestureRecognizer *)tap {
    ZCRecommendWidgetItemImageView *imageView = (ZCRecommendWidgetItemImageView *)tap.view;
    if ([self.delegate respondsToSelector:@selector(recommendCanScrollCellImageClickedWithItem:)]) {
        [self.delegate recommendCanScrollCellImageClickedWithItem:imageView.item];
    }
}

- (UIView *)myContentView {
    if (!_myContentView) {
        _myContentView = [[UIView alloc] init];
        _myContentView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _myContentView;
}

- (UIScrollView *)scrollview {
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc] init];
        _scrollview.showsVerticalScrollIndicator = NO;
        _scrollview.showsHorizontalScrollIndicator = NO;
        _scrollview.backgroundColor = [UIColor whiteColor];
        [_scrollview addSubview:self.myContentView];
    }
    return _scrollview;
}

// 注意：如果采用Masonry框架进行布局，那么当遇到scrollView时，情况有些特殊，如果scrollView的子控件也用masonry布局，那么此时直接设置scrollView的contentSize是没有想要的效果的，必须建立一张contentView作为scrollView的第一个子控件，然后再将其它子控件加在contentView上，并且，contentView的大小应该延伸至最后一个子控件，这样就相当于设置了scrollView的contentSize
- (void)layoutSubControls {
    [self.scrollview makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0);
        make.bottom.equalTo(0);
    }];

    [self.myContentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(idx * kImageViewW);
            make.top.bottom.equalTo(0);
            make.width.equalTo(kImageViewW);
        }];
    }];
    [self.myContentView remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollview);
        make.height.equalTo(self.scrollview);
        if (self.myContentView.subviews.count != 0) {
           make.right.equalTo(self.myContentView.subviews.lastObject.right);
        }
    }];
    
}

@end




