//
//  ZCMakeStepViewController.m
//  iZhangChu
//
//  Created by Libo on 17/6/9.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCMakeStepViewController.h"
#import "ZCMacro.h"
#import "ZCDishesMakeStepModel.h"
#import "ZCMakeStepCell.h"

static NSString * const cell_ID = @"stepCell";

@interface ZCMakeStepViewController ()
//@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ZCMakeStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCMakeStepCell class]) bundle:nil] forCellReuseIdentifier:cell_ID];
}

- (void)setSteps:(NSArray *)steps {
    _steps = steps;
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.steps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZCMakeStepCell *cell = [tableView dequeueReusableCellWithIdentifier: cell_ID forIndexPath:indexPath];
    cell.model = self.steps[indexPath.row];
    
    return cell;
}



@end
