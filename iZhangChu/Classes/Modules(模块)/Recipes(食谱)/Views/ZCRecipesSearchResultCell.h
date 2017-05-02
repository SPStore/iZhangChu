//
//  ZCRecipesSearchResultCell.h
//  iZhangChu
//
//  Created by Libo on 17/4/29.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZCRecipesSearchResultModel;

@interface ZCRecipesSearchResultCell : UITableViewCell

@property (nonatomic, strong) ZCRecipesSearchResultModel *model;
@property (nonatomic, copy) NSString *keyword;


@end
