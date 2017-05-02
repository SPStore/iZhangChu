//
//  ZCRecipesAutoSearchCell.m
//  iZhangChu
//
//  Created by Libo on 17/5/1.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecipesAutoSearchCell.h"
#import "ZCRecipesAutoSearchModel.h"
#import "ZCMacro.h"

@interface ZCRecipesAutoSearchCell()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *rightLabel;
@property (nonatomic, weak) UIView *line;


@end

@implementation ZCRecipesAutoSearchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *rightLabel = [[UILabel alloc] init];
        rightLabel.font = titleLabel.font;
        [self.contentView addSubview:rightLabel];
        self.rightLabel = rightLabel;
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor blackColor];
        line.alpha = 0.3;
        [self.contentView addSubview:line];
        self.line = line;
        
    }
    return self;
}

- (void)setGroup:(NSObject *)group {
    [super setGroup:group];
    
    ZCRecipesAutoSearchModel *autoModel = (ZCRecipesAutoSearchModel *)group;
    if (self.indexPath.section == 0) {
        NSMutableAttributedString *attString = [self setupString:self.keyword colorString:self.keyword];
        self.titleLabel.attributedText = attString;
        
        NSString *countString = [NSString stringWithFormat:@"相关食材%zd个",autoModel.count];
        NSMutableAttributedString *attCountString = [self setupString:countString colorString:[NSString stringWithFormat:@"%zd",autoModel.count]];
        self.rightLabel.attributedText = attCountString;
    } else {
        NSMutableAttributedString *attString = [self setupString:autoModel.text colorString:self.keyword];
        self.titleLabel.attributedText = attString;
    }
}

- (NSMutableAttributedString *)setupString:(NSString *)string colorString:(NSString *)colorString {
    if (string) {
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
        [attString addAttribute:NSForegroundColorAttributeName value:ZCGlobalColor range:[string rangeOfString:colorString]];
        return attString;
    }
    return nil;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)updateConstraints {
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(self);
        make.width.equalTo(80);
    }];
    
    [self.rightLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-15);
        make.centerY.equalTo(self);
        make.width.equalTo(120);
    }];
    
    [self.line makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.bottom.equalTo(-0.5);
        make.height.equalTo(0.5);
        make.width.equalTo(kScreenW-15);
        
    }];
    
    [super updateConstraints];
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

@end
