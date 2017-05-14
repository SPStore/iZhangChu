//
//  ZCRecommendMasterListCell.m
//  iZhangChu
//
//  Created by Shengping on 17/4/24.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecommendMasterListCell.h"
#import "ZCRecommendMasterListModel.h"
#import "ZCRecommendMasterListView.h"
#import "ZCRecommendWidgetItem.h"

@interface ZCRecommendMasterListCell()
@property (nonatomic, strong) UIView *containerView;
@end

@implementation ZCRecommendMasterListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *line = UIView.new;
        line.frame = CGRectMake(0, kTitleHeight, kScreenW, 0.5);
        line.backgroundColor = [UIColor grayColor];
        line.alpha = 0.5;
        [self.contentView addSubview:line];
        [self.contentView addSubview:self.containerView];
    }
    return self;
}

- (void)setModel:(ZCRecommendBasicModel *)model {
    [super setModel:model];
    
    self.title = model.title;
    
    NSMutableArray *iconItems = @[].mutableCopy;
    NSMutableArray *nickItems = @[].mutableCopy;
    NSMutableArray *accountItems = @[].mutableCopy;
    NSMutableArray *fansItems = @[].mutableCopy;
    
    for (ZCRecommendWidgetItem *item in model.widget_data) {
        if (item.id % 4 == 1) {
            [iconItems addObject:item];
        } else if (item.id % 4 == 2) {
            [nickItems addObject:item];
        } else if (item.id % 4 == 3) {
            [accountItems addObject:item];
        } else {
            [fansItems addObject:item];
        }
    }
    
    while (self.containerView.subviews.count < model.widget_data.count/4) {
        NSInteger count = self.containerView.subviews.count;
        if (iconItems.count >= count && nickItems.count >= count && accountItems.count >= count && fansItems.count >= count) {
            ZCRecommendWidgetItem *iconItem = iconItems[count];
            ZCRecommendWidgetItem *nickItem = nickItems[count];
            ZCRecommendWidgetItem *accountItem = accountItems[count];
            ZCRecommendWidgetItem *fansItem = fansItems[count];
            
            ZCRecommendMasterListView *listView = [ZCRecommendMasterListView masterListView];
            listView.iconItem = iconItem;
            listView.nickItem = nickItem;
            listView.accountItem = accountItem;
            listView.fansItem = fansItem;
            [self.containerView addSubview:listView];
        }
    }
    
    // 这个for循环是避免cell的复用，在这里可以不需要这样的for循环，因为每个这种类型的cell上的子控件都是相同的
    for (int i = 0; i < self.containerView.subviews.count; i++) {
        ZCRecommendMasterListView *listView = self.containerView.subviews[i];
        if (i < model.widget_data.count) {
            listView.hidden = NO;
        } else {
            listView.hidden = YES;
        }
    }
}

- (UIView *)containerView {
    
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        
    }
    return _containerView;
}

- (void)updateConstraints {
    [self.containerView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.top.equalTo(kTitleHeight+0.5);
    }];
    
    if (self.containerView.subviews.count > 1) {
        [self.containerView.subviews makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
        }];
        
        [self.containerView.subviews mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    }
    
    [super updateConstraints];
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}


@end
