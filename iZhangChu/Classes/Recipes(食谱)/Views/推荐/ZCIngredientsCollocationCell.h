//
//  ZCIngredientsCollocationCell.h
//  iZhangChu
//
//  Created by Libo on 17/5/9.
//  Copyright © 2017年 iDress. All rights reserved.
//  食材搭配的cell

#import <UIKit/UIKit.h>

@class ZCIngredientsButtonModel;

@interface ZCIngredientsCollocationCell : UICollectionViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) ZCIngredientsButtonModel *buttonModel;


@end
