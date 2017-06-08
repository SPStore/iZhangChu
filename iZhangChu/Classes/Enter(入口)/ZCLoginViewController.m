//
//  ZCLoginViewController.m
//  iZhangChu
//
//  Created by Libo on 17/5/15.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCLoginViewController.h"
#import "ZCRegisterViewController.h"

@interface ZCLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *agreeButtonAction;

@property (weak, nonatomic) IBOutlet UIButton *sureButton;

- (IBAction)backAction:(UIButton *)sender;

- (IBAction)registerAction:(UIButton *)sender;

- (IBAction)sureButtonAction:(UIButton *)sender;

@end

@implementation ZCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)shareToWeChat:(UIButton *)sender {
}
- (IBAction)shareToQQ:(UIButton *)sender {
}
- (IBAction)shareToTaoBao:(UIButton *)sender {
}
- (IBAction)shareToWeibo:(UIButton *)sender {
}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)registerAction:(UIButton *)sender {
    ZCRegisterViewController *registerVc = [[ZCRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVc animated:YES];
    
}

- (IBAction)sureButtonAction:(UIButton *)sender {
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
