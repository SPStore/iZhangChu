//
//  ZCRecipesHomeViewController.m
//  掌厨
//
//  Created by Shengping on 17/4/17.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCRecipesHomeViewController.h"
#import "ZCRecommendViewController.h"
#import "ZCIngredientsViewController.h"
#import "ZCCategoryViewController.h"
#import "ZCRecipesSearchViewController.h"
#import "ZCNavigationController.h"
#import "SPPageMenu.h"
#import "UIBarButtonItem+Style.h"

@interface ZCRecipesHomeViewController () <SPPageMenuDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SPPageMenu *pageMenu;

@end

@implementation ZCRecipesHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNavigationView];

    // 先添加好3个子控制器（推荐、食材、分类）
    [self addChildViewController:[[ZCRecommendViewController alloc] init]];
    [self addChildViewController:[[ZCIngredientsViewController alloc] init]];
    [self addChildViewController:[[ZCCategoryViewController alloc] init]];
    
    [self.view addSubview:self.scrollView];
    
    NSInteger count = self.childViewControllers.count;
    self.scrollView.contentSize = CGSizeMake(kScreenW*count, 0);
    for (int i = 0; i < count; i++) {
        UIViewController *viewController = self.childViewControllers[i];
        viewController.view.frame = CGRectMake(kScreenW*i, 0, kScreenW, kScreenH);
        [_scrollView addSubview:viewController.view];
    }
}

// 设置导航栏
- (void)setupNavigationView {

    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"saoyisao"] style:UIBarButtonItemStylePlain target:self action:@selector(scan:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:self action:@selector(search:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.navigationItem.titleView = self.pageMenu;
}

// pageMenu的代理方法
- (void)pageMenu:(SPPageMenu *)pageMenu buttonClickedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    // 如果上一次点击的button下标与当前点击的buton下标之差大于等于2,说明跨界面移动了,此时不动画.
    if (labs(toIndex - fromIndex) >= 2) {
        [self.scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * toIndex, 0) animated:NO];
    } else {
        [self.scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * toIndex, 0) animated:YES];
    }
    
    UIViewController *targetViewController = self.childViewControllers[toIndex];
    // 如果已经加载过，就不再加载
    if ([targetViewController isViewLoaded]) return;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    // 手动滑scrollView,pageMenu会根据传进去的index选中index对应的button
    [self.pageMenu selectButtonAtIndex:index];
}

// 扫描
- (void)scan:(UIButton *)sender {
    
}

// 搜索
- (void)search:(UIButton *)sender {
    
    ZCRecipesSearchViewController *searchVc = [[ZCRecipesSearchViewController alloc] init];
    // 用一个导航控制器包装，因为在搜索控制器中需要push。当然也可以拿到其他导航控制器去push，比如跟控制器的第一个导航控制器，但是那样做，就无法pop回搜索控制器
    ZCNavigationController *navi = [[ZCNavigationController alloc] initWithRootViewController:searchVc];
    [self presentViewController:navi animated:YES completion:nil];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
         _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH-64)];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (SPPageMenu *)pageMenu {
    if (!_pageMenu) {
        _pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(70, 20, kScreenW-140, 44) array:@[@"推荐",@"食材",@"分类"]];
        _pageMenu.backgroundColor = [UIColor whiteColor];
        _pageMenu.delegate = self;
        _pageMenu.buttonFont = [UIFont boldSystemFontOfSize:17];
        _pageMenu.selectedTitleColor = [UIColor blackColor];
        _pageMenu.unSelectedTitleColor = [UIColor grayColor];
        _pageMenu.trackerColor = [UIColor orangeColor];
        _pageMenu.showBreakline = NO;
        _pageMenu.allowBeyondScreen = NO;
        _pageMenu.equalWidths = YES;
        _pageMenu.animationSpeed = 0.1;
    }
    return _pageMenu;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
