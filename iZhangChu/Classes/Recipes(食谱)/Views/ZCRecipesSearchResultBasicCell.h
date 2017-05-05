//
//  ZCRecipesSearchResultBasicCell.h
//  iZhangChu
//
//  Created by Libo on 17/5/2.
//  Copyright © 2017年 iDress. All rights reserved.
//  搜索结果的cell基类

#import <UIKit/UIKit.h>

@interface ZCRecipesSearchResultBasicCell : UITableViewCell
@property (nonatomic, strong) NSObject *model;
@property (nonatomic, copy) NSString *keyword;
@end
