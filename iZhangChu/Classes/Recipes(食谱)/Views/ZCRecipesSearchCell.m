//
//  ZCRecipesSearchCell.m
//  iZhangChu
//
//  Created by Libo on 17/4/28.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecipesSearchCell.h"
#import "ZCMacro.h"

@interface ZCRecipesSearchCell ()
@property (nonatomic, weak) UILabel *titleLabel;
@end

@implementation ZCRecipesSearchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(15, 15, 80, 30);
        self.titleLabel = titleLabel;
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.alpha = 0.6;
        [self.contentView addSubview:titleLabel];
        
    }
    return self;
}

- (void)setGroup:(NSObject *)group {
    [super setGroup:group];
    
    ZCRecipesSearchGroup *searchGroup = (ZCRecipesSearchGroup *)group;
    
    self.titleLabel.text = searchGroup.title;
    
    while (self.contentView.subviews.count - 1 < searchGroup.searchArray.count) {
        ZCRecipesSearchButton *button = [ZCRecipesSearchButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:button];
    }
    
    CGFloat padding = 15;
    CGFloat buttonW = 0;
    CGFloat buttonH = 30;
    CGFloat buttonX = padding;
    CGFloat buttonY = CGRectGetMaxY(self.titleLabel.frame) + 15;
    CGFloat lastButtonMaxX = 0;
    
    for (int i = 0; i < self.contentView.subviews.count - 1; i++) {
        ZCRecipesSearchButton *button = self.contentView.subviews[i+1];
        
        if (i < searchGroup.searchArray.count) {
            ZCRecipesSearchModel *searchModel = searchGroup.searchArray[i];
            button.searchModel = searchModel;
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            button.layer.borderWidth = 1;
            
            if ([searchGroup.title isEqualToString:@"热门搜索"]) {
                button.layer.borderColor = ZCGlobalColor.CGColor;
                [button setTitleColor:ZCGlobalColor forState:UIControlStateNormal];
            } else {
                button.layer.borderColor = [UIColor grayColor].CGColor;
                [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
            
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            buttonW = [button.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:15]].width+15;
            buttonX = lastButtonMaxX + padding;
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            
            if (CGRectGetMaxX(button.frame) + padding > kScreenW) {
                buttonY = CGRectGetMaxY(button.frame) + padding;
                buttonX = padding;
                button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            }
            lastButtonMaxX = CGRectGetMaxX(button.frame);
            
            button.hidden = NO;
        } else {
            button.hidden = YES;
        }
    }
    
    ZCRecipesSearchButton *lastButton = self.contentView.subviews.lastObject;
    searchGroup.cellHeight = CGRectGetMaxY(lastButton.frame) + 15;
}


- (void)buttonAction:(ZCRecipesSearchButton *)sender {
    if (self.buttonClickedOnCellBlock) {
        self.buttonClickedOnCellBlock(sender);
    }
}


@end


@implementation ZCRecipesSearchButton

- (void)setSearchModel:(ZCRecipesSearchModel *)searchModel {
    _searchModel = searchModel;
    
    [self setTitle:searchModel.text forState:UIControlStateNormal];
}

@end
