//
//  ZCIngredientsCollocationBottomAlertView.m
//  iZhangChu
//
//  Created by Libo on 17/5/9.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCIngredientsCollocationBottomToolBar.h"
#import "ZCMacro.h"

#define kLeftMargin 12
#define kRightMargin 20
#define kTopMargin 15
#define kBotomMargin 13
#define kPadding 12
#define kButtonW (kScreenW-kLeftMargin-kRightMargin-3*kPadding)/4.0

@interface ZCIngredientsCollocationBottomToolBar()
// 加号按钮
@property (nonatomic, strong) UIButton *plusButton;
// 没有按钮时显示的文字Label
@property (nonatomic, strong) UILabel *textLabel;
// 装载按钮的数组
@property (nonatomic, strong) NSMutableArray *buttonArray;
// 最后一个按钮
@property (nonatomic, strong) UIButton *lastButton;

@end

@implementation ZCIngredientsCollocationBottomToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CALayer *topLayer = [CALayer layer];
        topLayer.frame = CGRectMake(0, 0, kScreenW, 1);
        topLayer.borderWidth = 1;
        topLayer.backgroundColor = [UIColor grayColor].CGColor;
        topLayer.opacity = 0.2;
        [self.layer addSublayer:topLayer];

        
        [self addSubview:self.textLabel];
        [self addSubview:self.plusButton];
        [self addSubview:self.countLabel];
        [self addSubview:self.rightTopButton];
        
        [self.textLabel makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).offset(0);
        }];
        
        [self.countLabel makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-kRightMargin);
            make.top.equalTo(kTopMargin);
            make.bottom.equalTo(-kBotomMargin);
            make.width.equalTo(kButtonW*1.1);
        }];
        
        [self.rightTopButton makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(0);
            make.size.equalTo(CGSizeMake(35, 25));
        }];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self addSubview:self.textLabel];
    }
    return self;
}

// 添加按钮
- (void)addButtonWithTitle:(NSString *)title {
    
    self.textLabel.hidden = YES;
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.backgroundColor = ZCGlobalColor;
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *cancelImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"material_cancel"]];
    [button addSubview:cancelImageView];
    [cancelImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button.right);
        make.centerY.equalTo(button.top);
        make.size.equalTo(CGSizeMake(16, 16));
    }];
    
    [self addSubview:button];
    [self.buttonArray addObject:button];
    
    [button updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kTopMargin);
        make.bottom.equalTo(-kBotomMargin);
        make.width.equalTo(kButtonW);
        if (!self.lastButton) {
            make.left.equalTo(kLeftMargin);
        } else {
            make.left.equalTo(self.lastButton.right).offset(self.lastButton ? kPadding : kLeftMargin);
        }
    }];
    
    self.lastButton = button;
    
    // 必须用ramake
    [self.plusButton remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lastButton.right).offset(kPadding);
        make.top.bottom.equalTo(self.lastButton);
        make.width.equalTo(self.lastButton);
    }];
    
    self.plusButton.hidden = (self.buttonArray.count > 2);
    self.countLabel.hidden = !(self.buttonArray.count > 1);
}

// 删除一个按钮
- (void)removeButtonWithIndex:(NSInteger)index {
    
    UIButton *button = self.buttonArray[index];
    [button removeFromSuperview];
    [self.buttonArray removeObject:button];
    
    // self.lastButton需要重指向
    self.lastButton = self.buttonArray.lastObject;
    
    if (self.buttonArray.count > index) {
        // 此时通过 index 和第一行取出来的button是不一样的
        UIButton *nextButton = self.buttonArray[index];
        
        if (index > 0) {
            UIButton *lastButton = self.buttonArray[index - 1];
            [nextButton updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastButton.right).offset(kPadding);
            }];
        } else {
            [nextButton updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(kLeftMargin);
            }];
        }
        
    }
    
    [self showTextLabel];
    
    [self showPlusButton];
    
    [self hideCountLabel];
    
}

// 显示提示label
- (void)showTextLabel {
    if (self.buttonArray.count == 0) {
        self.textLabel.hidden = NO;
        self.lastButton = nil;
    }
}

// 显示加号按钮，该按钮只起到了一个展示作用
- (void)showPlusButton {
    if (self.buttonArray.count < 3 && self.buttonArray.count != 0) {
        self.plusButton.hidden = NO;
        [self.plusButton remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lastButton.right).offset(kPadding);
            make.top.bottom.width.equalTo(self.lastButton);
        }];
    }
    if (self.buttonArray.count == 0) {
        self.plusButton.hidden = YES;
    }
}

// 隐藏可做几道菜的Label
- (void)hideCountLabel {
    if (self.buttonArray.count <= 1) {
        self.countLabel.hidden = YES;
    }
}

// 菜单按钮被点击
- (void)buttonClicked:(UIButton *)sender {
    NSInteger index = [self.buttonArray indexOfObject:sender];
    [self removeButtonWithIndex:index];
    
    if (self.dishButtonClickedBlock) {
        self.dishButtonClickedBlock(index);
    }
}

// 右上角的取消按钮被点击
- (void)rightTopButtonClicekd:(UIButton *)sender {
    if (self.rightTopButtonClickedBlock) {
        self.rightTopButtonClickedBlock(index);
    }
}

- (UILabel *)textLabel {
    
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.text = @"请选择2个或以上食材\n掌厨告诉你可以做什么";
        _textLabel.numberOfLines = 0;
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.alpha = 0.6;
        _textLabel.font = [UIFont systemFontOfSize:16];
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

- (UIButton *)plusButton {
    if (!_plusButton) {
        _plusButton = [[UIButton alloc] init];
        [_plusButton setImage:[UIImage imageNamed:@"material_add"] forState:UIControlStateNormal];
    }
    return _plusButton;
}

- (UILabel *)countLabel {
    
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.font = [UIFont systemFontOfSize:13];
        _countLabel.textColor = ZCGlobalColor;
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.hidden = YES;
        
    }
    return _countLabel;
}

- (UIButton *)rightTopButton {
    
    if (!_rightTopButton) {
        _rightTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightTopButton setBackgroundImage:[UIImage imageNamed:@"material_close"] forState:UIControlStateNormal];
        [_rightTopButton addTarget:self action:@selector(rightTopButtonClicekd:) forControlEvents:UIControlEventTouchUpInside];
        _rightTopButton.hidden = YES;
    }
    return _rightTopButton;
}


- (NSMutableArray *)buttonArray {
    
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
        
    }
    return _buttonArray;
}



@end
