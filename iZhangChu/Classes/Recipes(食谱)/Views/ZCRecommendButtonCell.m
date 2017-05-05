//
//  ZCRecommendLikeCell.m
//  iZhangChu
//
//  Created by Libo on 17/4/20.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecommendButtonCell.h"
#import "ZCRecommendButtonModel.h"

#define kTitleColor [UIColor blackColor]
#define kTitleFont [UIFont systemFontOfSize:13]
#define kTitleAlpha 0.8

@interface ZCRecommendButtonCell()

// 装载新手入门、食材搭配、场景菜谱、美食直播的大view
@property (nonatomic, strong) UIView *menuView;
// 新手入门
@property (nonatomic, strong) ZCRecommendLikeButton *basicIntroduceBtn;
// 食材搭配
@property (nonatomic, strong) ZCRecommendLikeButton *ingredientsCollocationBtn;
// 场景菜谱
@property (nonatomic, strong) ZCRecommendLikeButton *sceneRecipesBtn;
// 美食直播
@property (nonatomic, strong) ZCRecommendLikeButton *foodLiveBtn;

@end

@implementation ZCRecommendButtonCell
@synthesize delegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.menuView];
        
        UIView *line = UIView.new;
        line.alpha = 0.3;
        line.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:line];
        [line makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.bottom.equalTo(-0.5);
            make.right.equalTo(-10);
            make.height.equalTo(0.5);
        }];
        
    }
    return self;
}

- (void)setModel:(ZCRecommendBasicModel *)model {
    [super setModel:model];
    
    // 该cell上有四个大button,按理应该每个模型对应一个button，但是后台返回的数据并非如此，而是每两个模型对应一个button，所以要把widget_data数组分解成两个数组
    NSMutableArray *imageItems = @[].mutableCopy;
    NSMutableArray *textItems = @[].mutableCopy;
    
    for (ZCRecommendWidgetItem  *item in model.widget_data) {
        if ([item.type isEqualToString:@"image"]) { // image类型
            [imageItems addObject:item];
        } else { // text类型
            [textItems addObject:item];
        }
    }
    for (int i = 0; i < imageItems.count; i++) {
        
        if (textItems.count >= i) { // 该条件判断要不要都无所谓，只是为了以防万一，万一textItems数组与imageItems数组个数不一致呢
            ZCRecommendWidgetItem *imageItem = imageItems[i];
            ZCRecommendWidgetItem *textItem = textItems[i];
            if (self.menuView.subviews.count >= i) {
                ZCRecommendLikeButton *btn = self.menuView.subviews[i];
                btn.imageItem = imageItem;
                btn.textItem = textItem;
            }
        }
    }
}

- (void)menuBtnClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(buttonOnButtonCellClickedWithButtonType:)]) {
        [self.delegate buttonOnButtonCellClickedWithButtonType:sender.tag];
    }
}

- (ZCRecommendLikeButton *)foodLiveBtn {
    if (!_foodLiveBtn) {
        _foodLiveBtn = [ZCRecommendLikeButton buttonWithType:UIButtonTypeCustom];
        _foodLiveBtn.imagePosition = SPButtonImagePositionTop;
        [_foodLiveBtn setTitleColor:kTitleColor forState:UIControlStateNormal];
        _foodLiveBtn.titleLabel.font = kTitleFont;
        _foodLiveBtn.titleLabel.alpha = kTitleAlpha;
        _foodLiveBtn.tag = 4;
        [_foodLiveBtn addTarget:self action:@selector(menuBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _foodLiveBtn;
}

- (ZCRecommendLikeButton *)sceneRecipesBtn {
    if (!_sceneRecipesBtn) {
        _sceneRecipesBtn = [ZCRecommendLikeButton buttonWithType:UIButtonTypeCustom];
        _sceneRecipesBtn.imagePosition = SPButtonImagePositionTop;
        [_sceneRecipesBtn setTitleColor:kTitleColor forState:UIControlStateNormal];
        _sceneRecipesBtn.titleLabel.font = kTitleFont;
        _sceneRecipesBtn.titleLabel.alpha = kTitleAlpha;
        _sceneRecipesBtn.tag = 3;
        [_sceneRecipesBtn addTarget:self action:@selector(menuBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sceneRecipesBtn;
}

- (ZCRecommendLikeButton *)ingredientsCollocationBtn {
    if (!_ingredientsCollocationBtn) {
        _ingredientsCollocationBtn = [ZCRecommendLikeButton buttonWithType:UIButtonTypeCustom];
        _ingredientsCollocationBtn.imagePosition = SPButtonImagePositionTop;
        _ingredientsCollocationBtn.titleLabel.font = kTitleFont;
        [_ingredientsCollocationBtn setTitleColor:kTitleColor forState:UIControlStateNormal];
        _ingredientsCollocationBtn.titleLabel.alpha = kTitleAlpha;
        _ingredientsCollocationBtn.tag = 2;
        [_ingredientsCollocationBtn addTarget:self action:@selector(menuBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ingredientsCollocationBtn;
}

- (ZCRecommendLikeButton *)basicIntroduceBtn {
    if (!_basicIntroduceBtn) {
        _basicIntroduceBtn = [ZCRecommendLikeButton buttonWithType:UIButtonTypeCustom];
        _basicIntroduceBtn.imagePosition = SPButtonImagePositionTop;
        [_basicIntroduceBtn setTitleColor:kTitleColor forState:UIControlStateNormal];
        _basicIntroduceBtn.titleLabel.font = kTitleFont;
        _basicIntroduceBtn.titleLabel.alpha = kTitleAlpha;
        _basicIntroduceBtn.tag = 1;
        [_basicIntroduceBtn addTarget:self action:@selector(menuBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _basicIntroduceBtn;
}

- (UIView *)menuView {
    if (!_menuView) {
        _menuView = [[UIView alloc] init];
        _menuView.backgroundColor = [UIColor whiteColor];
        [_menuView addSubview:self.basicIntroduceBtn];
        [_menuView addSubview:self.ingredientsCollocationBtn];
        [_menuView addSubview:self.sceneRecipesBtn];
        [_menuView addSubview:self.foodLiveBtn];
    }
    return _menuView;
}

- (void)updateConstraints {
    [self.menuView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(10);
        make.bottom.equalTo(-10);
    }];
    
    [self.menuView.subviews makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.bottom.equalTo(0);
    }];
    // 左右间距为0，间隔为0，宽度自适应
    [self.menuView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [super updateConstraints];
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

@end

#import <UIButton+WebCache.h>

@implementation ZCRecommendLikeButton

- (void)setImageItem:(ZCRecommendWidgetItem *)imageItem {
    _imageItem = imageItem;
    [self sd_setImageWithURL:[NSURL URLWithString:imageItem.content] forState:UIControlStateNormal];
}

- (void)setTextItem:(ZCRecommendWidgetItem *)textItem {
    _textItem = textItem;
    [self setTitle:textItem.content forState:UIControlStateNormal];
}

@end



