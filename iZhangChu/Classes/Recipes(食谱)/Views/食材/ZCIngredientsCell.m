//
//  ZCIngredientsCell.m
//  iZhangChu
//
//  Created by Shengping on 17/4/24.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCIngredientsCell.h"
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
#import "ZCIngredientsButtonModel.h"

@interface ZCIngredientsCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *firstImageView;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@end

@implementation ZCIngredientsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.firstImageView];
        
        [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(kLeftMargin);
            make.right.equalTo(100);
            make.top.equalTo(kTopMargin);
            make.height.equalTo(kTitleLabelH);
        }];
        
        [self.firstImageView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel);
            make.top.equalTo(self.titleLabel.bottom).offset(kTopMargin);
            make.width.equalTo(kFirstImageViewW);
            make.height.equalTo(kButtonH * 2 + kButtonPadding);
        }];
    }
    return self;
}

- (void)setModel:(ZCIngredientsDataModel *)model {
    _model = model;
    
    self.titleLabel.text = model.text;
    [self.firstImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    
    NSInteger count = model.data.count;

    // while+for循环组合 创建与设置button,这种方式大大降低tableView的卡顿
    while (self.buttonArray.count < count) { // 不够则创建，够的话不用重复创建
        ZCIngredientsButton *btn = [ZCIngredientsButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        [self.buttonArray addObject:btn];
    }
    
    /*
    double date_s = CFAbsoluteTimeGetCurrent();
    
    [self.buttonArray enumerateObjectsUsingBlock:^(ZCIngredientsButton * _Nonnull btn, NSUInteger i, BOOL * _Nonnull stop) {
        if (i < count) {
            // 只有显示出来的按钮才去做相关设置
            ZCIngredientsButtonModel *btnModel = model.data[i];
            btn.btnModel = btnModel;
            btn.hidden = NO;
        } else {
            btn.hidden = YES;
        }
    }];
    double date_current = CFAbsoluteTimeGetCurrent() - date_s;
     NSLog(@"enum Time: %f ms",date_current * 1000);
    
    date_s = CFAbsoluteTimeGetCurrent();
    for (ZCIngredientsButton *btn in self.buttonArray) {
        NSInteger i = [self.buttonArray indexOfObject:btn];
        if (i < count) {
            // 只有显示出来的按钮才去做相关设置
            ZCIngredientsButtonModel *btnModel = model.data[i];
            btn.btnModel = btnModel;
            btn.hidden = NO;
        } else {
            btn.hidden = YES;
        }
    }

    date_current = CFAbsoluteTimeGetCurrent() - date_s;
    NSLog(@"for in Time: %f ms",date_current * 1000);
    */
    // 这个for循环的最大作用是解决cell的复用，比如第一个cell上有30个button ，第二个cell上有20个button，当第二个cell复用第一个cell时，第二个cell则会显示30个button，我们要将多余的10个隐藏掉
    //date_s = CFAbsoluteTimeGetCurrent();
    for (int i = 0; i < self.buttonArray.count; i++) {
        ZCIngredientsButton *btn = self.buttonArray[i];
        if (i < count) {
            // 只有显示出来的按钮才去做相关设置
            ZCIngredientsButtonModel *btnModel = model.data[i];
            btn.btnModel = btnModel;
            btn.hidden = NO;
        } else {
            btn.hidden = YES;
        }
    }
    [self layoutSubControl];
}

- (NSMutableArray *)buttonArray {
    
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
        
    }
    return _buttonArray;
}


- (UIImageView *)firstImageView {
    if (!_firstImageView) {
        _firstImageView = [[UIImageView alloc] init];
        _firstImageView.backgroundColor = ZCBackgroundColor;
    }
    return _firstImageView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.alpha = 0.6;
        
    }
    return _titleLabel;
}

- (void)layoutSubControl {
 
    NSInteger maxCol = 3;
    __block int i = 0;
    [self.buttonArray makeConstraints:^(MASConstraintMaker *make) {
        
        if (i < 6) {
            NSInteger col = i % maxCol;
            NSInteger row = i / maxCol;
            make.width.equalTo(kButtonW);
            make.height.equalTo(kButtonH);
            make.left.equalTo(col * (kButtonW + kButtonPadding) + kLeftMargin + kFirstImageViewW + kButtonPadding);
            make.top.equalTo(self.firstImageView).offset(row * (kButtonH + kButtonPadding));
        }else {
            NSInteger col = (i-6) % kMaxCol;
            NSInteger row = (i-6) / kMaxCol;
            make.width.equalTo(kButtonW);
            make.height.equalTo(kButtonH);
            make.left.equalTo(col * (kButtonW + kButtonPadding) + kLeftMargin);
            make.top.equalTo(self.firstImageView.bottom).offset(row * (kButtonH + kButtonPadding) + kButtonPadding);
        }
        
        i++;
    }];
}


@end


@implementation ZCIngredientsButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ZCBackgroundColor;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.alpha = 0.6;
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self sizeToFit];
    }
    return self;
}

- (void)setBtnModel:(ZCIngredientsButtonModel *)btnModel {
    _btnModel = btnModel;
    [self setTitle:btnModel.text forState:UIControlStateNormal];
}

@end




