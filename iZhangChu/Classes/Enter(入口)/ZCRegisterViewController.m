//
//  ZCRegisterViewController.m
//  iZhangChu
//
//  Created by Libo on 17/5/15.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRegisterViewController.h"

@interface ZCRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageYanZhengmaTextField;
@property (weak, nonatomic) IBOutlet UIButton *imageYanZhengmaBtn;

@property (weak, nonatomic) IBOutlet UITextField *yanZhengMaTextField;
@property (weak, nonatomic) IBOutlet UIButton *fetchYanZhengMaBtn;


@end

@implementation ZCRegisterViewController

- (IBAction)changeBtnAction:(UIButton *)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
