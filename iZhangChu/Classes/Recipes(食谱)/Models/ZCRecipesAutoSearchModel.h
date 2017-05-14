//
//  ZCRecipesAutoSearchModel.h
//  iZhangChu
//
//  Created by Shengping on 17/5/1.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCBasicModel.h"
// 这个模型要特别注意：在自动搜索的cell中，第一个cell和其它cell所对应的模型是不一致的，自动搜索的接口数据经过字典转模型后，有两种模型，一种模型对应第一个cell，另一种模型对应其余cell。但是在这里，我把这两种模型合在了一起，要不然两种模型又要对应两种cell，第一个cell和其余cell的类型可以是一致的，无需搞两种cell
@interface ZCRecipesAutoSearchModel : ZCBasicModel

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSArray *data;

@end


@interface ZCRecipesAutoSearchTopListModel : ZCBasicModel

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *video;

@end
