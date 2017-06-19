//
//  ZCDishedInfoViewController.m
//  iZhangChu
//
//  Created by Libo on 17/6/9.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCDishedInfoViewController.h"
#import "ZCMacro.h"
#import "ZCDishesInfoModel.h"
#import "ZCDishesInfoHeaderView.h"
#import "SPPageMenu.h"
#import "ZCMakeStepViewController.h"
#import "ZCMaterialViewController.h"
#import "ZCCommensenseViewController.h"
#import "ZCSuitableViewController.h"

#define PageMenuH 40
#define kNaviH 64

@interface ZCDishedInfoViewController () <SPPageMenuDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ZCDishesInfoHeaderView *headerView;
@property (nonatomic, strong) SPPageMenu *pageMenu;

@property (nonatomic, assign) CGFloat headerViewH;

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) CGFloat lastPageMenuY;
@end

@implementation ZCDishedInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navTitleColor = [UIColor whiteColor];
    self.navTintColor = [UIColor whiteColor];
    self.navBarTintColor = [UIColor whiteColor];
    self.navAlpha = 0;
    
    [self.view addSubview:self.scrollView];
    
    // 添加4个控制器
    ZCMakeStepViewController *makeVc = [[ZCMakeStepViewController alloc] init];
    makeVc.headerView = self.headerView;
    [self addChildViewController:makeVc];
    
    ZCMaterialViewController *materialVc = [[ZCMaterialViewController alloc] init];
    materialVc.dishes_id = self.dishes_id;
    [self addChildViewController:materialVc];
    
    ZCCommensenseViewController *commensenseVc = [[ZCCommensenseViewController alloc] init];
    commensenseVc.dishes_id = self.dishes_id;
    [self addChildViewController:commensenseVc];
    
    ZCSuitableViewController *suitableVc = [[ZCSuitableViewController alloc] init];
    suitableVc.dishes_id = self.dishes_id;
    [self addChildViewController:suitableVc];
    
    [self.scrollView addSubview:self.childViewControllers[0].view];
    self.scrollView.contentSize = CGSizeMake(kScreenW*4, 0);
    
    // 菜单
    [self.view addSubview:self.pageMenu];

    // 监听子控制器发出的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(subScrollViewDidScroll:) name:@"SubScrollViewDidScroll" object:nil];
    
    [self requestData];
}

// 设置子控制器的头部高度，因为只有网络请求到数据之后才能精确确定头部的高度
- (void)setupSubViewControllerHeaderViewH:(CGFloat)h {

    ZCMakeStepViewController *makeStepVc = self.childViewControllers[0];
    ZCMaterialViewController *materialVC = self.childViewControllers[1];
    ZCCommensenseViewController *commensenseVc = self.childViewControllers[2];
    ZCSuitableViewController *suitableVc = self.childViewControllers[3];
    makeStepVc.headerViewH = h;
    materialVC.headerViewH = h;
    commensenseVc.headerViewH = h;
    suitableVc.headerViewH = h;
}


- (void)requestData {
    NSMutableDictionary *params = [NSMutableDictionary dictionary ];
    params[@"methodName"] = @"DishesView";
    params[@"dishes_id"] = self.dishes_id;
    params[@"user_id"] = @"0";
    params[@"token"] = @"0";
    params[@"version"] = @4.92;
    
    [[SPHTTPSessionManager shareInstance] POST:ZCHOSTURL params:params success:^(id  _Nonnull responseObject) {
        // 字典转模型
        ZCDishesInfoModel *dishInfoModel = [ZCDishesInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
        // 标题
        self.navigationItem.title = dishInfoModel.dishes_name;
        // 给头部传模型
        self.headerView.model = dishInfoModel;
        // 设置悬浮菜单的初始位置
        self.pageMenu.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), kScreenW, PageMenuH);
        // 记录头部高度
        _headerViewH = CGRectGetMaxY(self.headerView.frame);
        self.lastPageMenuY = _headerViewH;
        [self changeStatusBarColor];
        // 给每个子控制器的头部赋予高度
        [self setupSubViewControllerHeaderViewH:_headerViewH];
        // 第一个子控制器的数据来源于该网络请求，故通过传值传过去
        ZCMakeStepViewController *makeStepVc = self.childViewControllers[0];
        // dishInfoModel.step是一个数组，里面装着步骤模型
        makeStepVc.steps = dishInfoModel.step;
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
    }];
}


// 本类中的scrollView的代理方法(目前本类只有一个self.scrollView)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.scrollView) {
        // 将当前控制器的view带到最前面去，这是为了防止下一个控制器的view挡住了头部
        ZCDishInfoBaseViewController *baseVc = self.childViewControllers[_selectedIndex];
        if ([baseVc isViewLoaded]) { // 防止提前使用view，一旦使用了view就会走viewDidLoaded
            [self.scrollView bringSubviewToFront:baseVc.view];
        }
        
        CGRect headerFrame = self.headerView.frame;
        headerFrame.origin.x = scrollView.contentOffset.x-kScreenW*_selectedIndex;
        self.headerView.frame = headerFrame;
        
        [self configerHeaderY];
        
        // 如果scrollView的内容很少，在屏幕范围内，则自动回落
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (baseVc.scrollView.contentSize.height < kScreenH && [baseVc isViewLoaded]) {
                [baseVc.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
        });
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
        // 手动滑scrollView,pageMenu会根据传进去的index选中index对应的button
        [self.pageMenu selectButtonAtIndex:index];
        
        [self configerHeaderY];
    }
}

// 子控制器上的scrollView已经滑动的代理方法所发出的通知方法
- (void)subScrollViewDidScroll:(NSNotification *)noti {
    
    // 取出当前正在滑动的tableView
    UIScrollView *scrollingScrollView = noti.userInfo[@"scrollingScrollView"];
    CGFloat offsetDifference = [noti.userInfo[@"offsetDifference"] floatValue];
    
    CGFloat distanceY;
    
    // 取出的scrollingScrollView并非是唯一的，当有多个子控制器上的scrollView同时滑动时都会发出通知来到这个方法，所以要过滤
    ZCDishInfoBaseViewController *baseVc = self.childViewControllers[_selectedIndex];
    
    if (scrollingScrollView == baseVc.scrollView && baseVc.isFirstViewLoaded == NO) {
        
        // 让悬浮菜单跟随scrollView滑动
        CGRect pageMenuFrame = self.pageMenu.frame;
        
        if (pageMenuFrame.origin.y >= kNaviH) {
            // 往上移
            if (offsetDifference > 0) {
                
                if (((scrollingScrollView.contentOffset.y+self.pageMenu.frame.origin.y)>=_headerViewH) || scrollingScrollView.contentOffset.y < 0) {
                    // 悬浮菜单的y值等于当前正在滑动且显示在屏幕范围内的的scrollView的contentOffset.y的改变量(这是最难的点)
                    pageMenuFrame.origin.y += -offsetDifference;
                    if (pageMenuFrame.origin.y <= kNaviH) {
                        pageMenuFrame.origin.y = kNaviH;
                    }
                }
            } else { // 往下移
                if ((scrollingScrollView.contentOffset.y+self.pageMenu.frame.origin.y)<_headerViewH) {
                    pageMenuFrame.origin.y = -scrollingScrollView.contentOffset.y+_headerViewH;
                    if (pageMenuFrame.origin.y <= kNaviH) {
                        pageMenuFrame.origin.y = kNaviH;
                    }
                }
            }
        }
        self.pageMenu.frame = pageMenuFrame;
        
        // 配置头视图的y值
        [self configerHeaderY];
        
        // 记录悬浮菜单的y值改变量
        distanceY = pageMenuFrame.origin.y - self.lastPageMenuY;
        self.lastPageMenuY = self.pageMenu.frame.origin.y;
        
        // 让其余控制器的scrollView跟随当前正在滑动的scrollView滑动
        [self followScrollingScrollView:scrollingScrollView distanceY:distanceY];
        
        [self changeColorWithOffsetY:-self.pageMenu.frame.origin.y+_headerViewH];
        [self changeStatusBarColor];
    }
    baseVc.isFirstViewLoaded = NO;
}

// 所有子控制器上的特定scrollView同时联动
- (void)followScrollingScrollView:(UIScrollView *)scrollingScrollView distanceY:(CGFloat)distanceY{
    ZCDishInfoBaseViewController *baseVc = nil;
    for (int i = 0; i < self.childViewControllers.count; i++) {
        baseVc = self.childViewControllers[i];
        if (baseVc.scrollView == scrollingScrollView) {
            continue;
        } else {
            // 除去当前正在滑动的 scrollView之外，其余scrollView的改变量等于悬浮菜单的改变量
            CGPoint contentOffSet = baseVc.scrollView.contentOffset;
            contentOffSet.y += -distanceY;
            baseVc.scrollView.contentOffset = contentOffSet;
        }
    }
}

- (void)configerHeaderY {
    // 取出当前子控制器
    ZCDishInfoBaseViewController *baseVc = self.childViewControllers[_selectedIndex];
    CGRect headerFrame = self.headerView.frame;
    // 将pageMenu的frame转换到当前正在滑动的scrollView(tableView)上去（这一步很关键）
    CGRect pageMenuFrameInScrollView = [self.pageMenu convertRect:self.pageMenu.bounds toView:baseVc.scrollView];
    // 每个tableView的头视图的y值都等于pageMenu的y值减去头部高度，这是为了保证头部的底部永远跟pageMenu的顶部紧贴
    headerFrame.origin.y = pageMenuFrameInScrollView.origin.y-_headerViewH;
    self.headerView.frame = headerFrame;
}

#pragma mark - SPPageMenuDelegate
- (void)pageMenu:(SPPageMenu *)pageMenu buttonClickedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    _selectedIndex = toIndex;
    // 如果上一次点击的button下标与当前点击的buton下标之差大于等于2,说明跨界面移动了,此时不动画.
    if (labs(toIndex - fromIndex) >= 2) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * toIndex, 0) animated:NO];
        });
        
    } else {
        // 如果有动画为yes，则不会走scrollViewDidScroll的代理方法,否则会走
        [self.scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * toIndex, 0) animated:YES];
    }
    
    ZCDishInfoBaseViewController *targetViewController = self.childViewControllers[toIndex];
    targetViewController.headerView = self.headerView;
    // 如果已经加载过，就不再加载
    if ([targetViewController isViewLoaded]) return;
    
    targetViewController.isFirstViewLoaded = YES;
    
    targetViewController.view.frame = CGRectMake(kScreenW*toIndex, 0, kScreenW, kScreenH);
    UIScrollView *s = targetViewController.scrollView;
    CGPoint contentOffset = s.contentOffset;
    contentOffset.y = -self.pageMenu.frame.origin.y+_headerViewH;
    if (contentOffset.y >= _headerViewH) {
        contentOffset.y = _headerViewH;
    }
    s.contentOffset = contentOffset;
    [self.scrollView addSubview:targetViewController.view];
}

- (void)changeColorWithOffsetY:(CGFloat)offsetY {
    
    if (offsetY >= 64) {
        CGFloat alpha = (offsetY-64)/(_headerViewH-64);
        // 该属性是设置导航栏背景渐变
        self.navAlpha = alpha;

        self.navTintColor = [UIColor grayColor];
        
        self.navTitleColor = [UIColor colorWithWhite:1-alpha alpha:1];
        
    } else {
        self.navAlpha = 0;
        self.navTintColor = [UIColor whiteColor];
        self.navTitleColor = [UIColor whiteColor];
    }
    
}

- (void)changeStatusBarColor {
    // 调用preferredStatusBarStyle改变状态栏的颜色
    [self setNeedsStatusBarAppearanceUpdate];
}

// 要系统自动调用这个方法，要在导航控制器中实现-(UIViewController *)childViewControllerForStatusBarStyle方法
- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.pageMenu.frame.origin.y < 300 && self.pageMenu.frame.origin.y > 0) {
        return UIStatusBarStyleDefault;
    } else {
        return UIStatusBarStyleLightContent;
    }
}

- (SPPageMenu *)pageMenu {
    
    if (!_pageMenu) {
        _pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame) + 10, kScreenW, PageMenuH) array:@[@"做法",@"食材",@"相关常识",@"相宜相克"]];
        _pageMenu.backgroundColor = [UIColor whiteColor];
        _pageMenu.delegate = self;
        _pageMenu.buttonFont = [UIFont systemFontOfSize:16];
        _pageMenu.selectedTitleColor = [UIColor blackColor];
        _pageMenu.unSelectedTitleColor = [UIColor colorWithWhite:0 alpha:0.6];
        _pageMenu.trackerColor = ZCGlobalColor;
        _pageMenu.firstButtonX = 15;
        _pageMenu.allowBeyondScreen = NO;
        _pageMenu.equalWidths = NO;
        
    }
    return _pageMenu;
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(kScreenW*(self.childViewControllers.count), 0);
        _scrollView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    }
    return _scrollView;
}

- (ZCDishesInfoHeaderView *)headerView {
    
    if (!_headerView) {
        _headerView = [ZCDishesInfoHeaderView sharedDishesInfoHeaderView];
        // 高度先随便给
        _headerView.frame = CGRectMake(0, 0, kScreenW, CGFLOAT_MIN);
        _headerView.backgroundColor = [UIColor whiteColor];
        
    }
    return _headerView;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
