//
//  ZCIngredientsDataModel.h
//  iZhangChu
//
//  Created by Shengping on 17/4/24.
//  Copyright © 2017年 iDress. All rights reserved.
//  食材数据

#import <Foundation/Foundation.h>
#import "ZCMacro.h"

#define kTitleLabelH 30

#define kTopMargin 10.0f
#define kLeftMargin 10.0f
#define kRightMargin 10.f
#define kBottomMargin 10.0f
#define kButtonPadding 10.0f

#define kMaxCol 5

#define kButtonW (kScreenW-kLeftMargin-kRightMargin-(kMaxCol-1)*kButtonPadding) / kMaxCol
#define kButtonH kButtonW * 2.0 / 3.0

#define kFirstImageViewW kButtonW*2+kButtonPadding

@interface ZCIngredientsDataModel : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) NSArray *data;


/**
 cell的高度
 */
@property (nonatomic, assign) float cellHeight;

/**
 用来标记该model对应的cell是否选中
 */
@property (nonatomic, assign) BOOL selected;

@end
