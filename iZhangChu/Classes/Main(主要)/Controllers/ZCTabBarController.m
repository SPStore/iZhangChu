//
//  ZCTabBarController.m
//  掌厨
//
//  Created by Libo on 17/4/17.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCTabBarController.h"
#import "ZCRecipesHomeViewController.h"
#import "ZCLohasHomeViewController.h"
#import "ZCCommunityHomeViewController.h"
#import "ZCMineHomeViewController.h"

#import "ZCNavigationController.h"

#import "ZCMacro.h"

@interface ZCTabBarController ()

@end

@implementation ZCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 取消tabBar的半透明效果
    self.tabBar.translucent = NO;
    
    // 初始化子控制器
    // 微信(首页)
    ZCRecipesHomeViewController *recipesVc = [[ZCRecipesHomeViewController alloc] init];
    [self addChildController:recipesVc
                       title:@"食谱"
                       image:@"home_normal"
               selectedImage:@"home_select"];
    
    // 通讯录
    ZCLohasHomeViewController *lohasVc = [[ZCLohasHomeViewController alloc] init];
    
    [self addChildController:lohasVc
                       title:@"乐活"
                       image:@"shike_normal"
               selectedImage:@"shike_select"];
    
    // 发现
    ZCCommunityHomeViewController *communityVc = [[ZCCommunityHomeViewController alloc] init];
    [self addChildController:communityVc
                       title:@"社区"
                       image:@"community_normal"
               selectedImage:@"community_select"];
    
    // 我
    ZCMineHomeViewController *mineVc = [[ZCMineHomeViewController alloc] init];
    [self addChildController:mineVc
                       title:@"我的"
                       image:@"mine_normal"
               selectedImage:@"mine_select"];
}

/**
 *  添加一个子控制器
 *
 */
- (void)addChildController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    // childController.title = title;            // 同时设置tabbar和navigationBar的文字
    childController.tabBarItem.title = title;     // 设置tabbar的文字
    //  childController.navigationItem.title = title; // 设置navigationBar的文字
    
    // 设置子控制器的图片
    // UIImageRenderingModeAlwaysOriginal保持原始图片，不让其渲染，否则所有的tabBar图片都默认为蓝色
    if (greaterThaniOS(7)) {
        childController.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    else {
        childController.tabBarItem.image = [UIImage imageNamed:image];
        childController.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    // 正常状态下的颜色
//    textAttrs[NSForegroundColorAttributeName] = ZCColorRGBA(146, 146, 146, 1);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    // 选中状态下的颜色设置为掌厨的主色调
    selectTextAttrs[NSForegroundColorAttributeName] = ZCGlobalColor;
    [childController.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childController.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    // 先给外面传进来的小控制器 包装 一个导航控制器
    ZCNavigationController *nav = [[ZCNavigationController alloc] initWithRootViewController:childController];
    // 添加为子控制器
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
