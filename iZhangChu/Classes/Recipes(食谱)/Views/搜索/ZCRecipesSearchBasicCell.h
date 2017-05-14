//
//  ZCRecipesSearchBasicCell.h
//  iZhangChu
//
//  Created by Shengping on 17/5/1.
//  Copyright © 2017年 iDress. All rights reserved.
//  搜索cell和自动搜索cell的基类

#import <UIKit/UIKit.h>

@interface ZCRecipesSearchBasicCell : UITableViewCell {
    NSIndexPath *_indexPath;
}

@property (nonatomic, strong) NSObject *group;

@property (nonatomic, copy) NSString *keyword;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end
