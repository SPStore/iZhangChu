//
//  ZCRecipesSearchResultViewController.h
//  iZhangChu
//
//  Created by Shengping on 17/4/29.
//  Copyright © 2017年 iDress. All rights reserved.
//  食谱中的搜索结果控制器

#import "ZCBasicViewController.h"

@interface ZCRecipesSearchResultViewController : ZCBasicViewController

@property (nonatomic, copy) NSString *keyword;

@property (nonatomic, strong) NSArray *dishes;

@end
