//
//  ZCDishInfoBaseViewController.m
//  iZhangChu
//
//  Created by Libo on 17/6/12.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCDishInfoBaseViewController.h"
#import "ZCMacro.h"

@interface ZCDishInfoBaseViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZCDishesInfoHeaderContentView *placeholderHeaderView;
@end

@implementation ZCDishInfoBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableHeaderView = self.placeholderHeaderView;
    [self.view addSubview:self.tableView];
    self.scrollView = self.tableView;
    
}

- (void)setHeaderViewH:(CGFloat)headerViewH {
    _headerViewH = headerViewH;
    self.placeholderHeaderView.zc_height = headerViewH+40;
    self.headerView.zc_height = headerViewH;
    UITableView *tableView = (UITableView *)self.scrollView;
    tableView.tableHeaderView = self.placeholderHeaderView;
}


- (void)setHeaderView:(ZCDishesInfoHeaderView *)headerView {
    _headerView = headerView;
    CGRect headerFrame = self.headerView.frame;
    // 修正origin
    headerFrame.origin.y = 0;
    headerFrame.origin.x = 0;
    self.headerView.frame = headerFrame;
    [self.placeholderHeaderView addSubview:headerView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetDifference = scrollView.contentOffset.y - self.lastContentOffset.y;
    // 滚动时发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubScrollViewDidScroll" object:nil userInfo:@{@"scrollingScrollView":scrollView,@"offsetDifference":@(offsetDifference)}];
    self.lastContentOffset = scrollView.contentOffset;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.lastContentOffset = scrollView.contentOffset;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell_1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%zd行",indexPath.row];
    return cell;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.layer.masksToBounds = NO;
    }
    return _tableView;
}

- (ZCDishesInfoHeaderContentView *)placeholderHeaderView {
    
    if (!_placeholderHeaderView) {
        _placeholderHeaderView = [[ZCDishesInfoHeaderContentView alloc] init];
        _placeholderHeaderView.frame = CGRectMake(0, 0, kScreenW, 300);
        _placeholderHeaderView.backgroundColor = [UIColor whiteColor];
    }
    return _placeholderHeaderView;
}


@end
