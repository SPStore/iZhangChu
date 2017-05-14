//
//  ZCIngredientsButtonModel.h
//  iZhangChu
//
//  Created by Shengping on 17/4/24.
//  Copyright © 2017年 iDress. All rights reserved.
//  食材中每个按钮对应的模型

#import <UIKit/UIKit.h>

@interface ZCIngredientsButtonModel : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *text;


@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) float left;
@property (nonatomic, assign) float top;

// 标记此模型对应的cell是否选中
@property (nonatomic, assign) BOOL selected;

@property (nonatomic, assign) NSInteger tag;

@end
