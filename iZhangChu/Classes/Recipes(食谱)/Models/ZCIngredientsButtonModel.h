//
//  ZCIngredientsButtonModel.h
//  iZhangChu
//
//  Created by Libo on 17/4/24.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCIngredientsButtonModel : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *text;

// 标记此模型对应的cell是否选中
@property (nonatomic, assign) BOOL selected;

@property (nonatomic, assign) NSInteger tag;

@end
