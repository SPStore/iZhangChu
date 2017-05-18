//
//  ZCMineHomeHeaderView.m
//  iZhangChu
//
//  Created by Shengping on 17/5/13.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCMineHomeHeaderView.h"

@interface ZCMineHomeHeaderView()
@property (weak, nonatomic) IBOutlet UIButton *headerIconBtn;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation ZCMineHomeHeaderView

+ (instancetype)shareMineHomeHeaderView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}
- (IBAction)setting:(UIButton *)sender {
    if (self.settingBlock) {
        self.settingBlock();
    }
}

@end
