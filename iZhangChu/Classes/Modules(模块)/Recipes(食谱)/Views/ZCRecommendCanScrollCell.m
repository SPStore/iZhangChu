//
//  ZCRecommendLuckyMoneyEnterCell.m
//  iZhangChu
//
//  Created by Libo on 17/4/20.
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
        imageview.showMaskView = NO;
        imageview.item = item;
        [self.myContentView addSubview:imageview];
    }
}

- (UIView *)myContentView {
    if (!_myContentView) {
        _myContentView = [[UIView alloc] init];
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
- (void)updateConstraints {
    [self.scrollview makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0);
        make.bottom.equalTo(0);
    }];
    
    __block int i = 0;
    
    [self.myContentView.subviews makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(kImageViewW);
        make.left.equalTo(i*kImageViewW);
        make.top.bottom.equalTo(0);
        i++;
    }];
    [self.myContentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollview);
        make.height.equalTo(self.scrollview);
        make.right.equalTo(self.myContentView.subviews.lastObject.right);
    }];
    
    [super updateConstraints];
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

@end




