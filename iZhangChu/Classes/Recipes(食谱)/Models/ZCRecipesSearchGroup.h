//
//  ZCRecipesSearchGroup.h
//  iZhangChu
//
//  Created by Libo on 17/4/28.
//  Copyright © 2017年 iDress. All rights reserved.
//  组模型

#import "ZCBasicModel.h"

@class ZCRecipesSearchModel;

// 搜索cell(展示历史记录和热门搜索)中的分区模型
@interface ZCRecipesSearchGroup : ZCBasicModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSMutableArray<ZCRecipesSearchModel *> *searchArray;

@property (nonatomic, assign) float cellHeight;
@end


// 搜索cell(展示历史记录和热门搜索)中的按钮对应的模型
@interface ZCRecipesSearchModel : ZCBasicModel

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *text;

@end
