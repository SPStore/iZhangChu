//
//  ZCIngredientSqlite.h
//  iZhangChu
//
//  Created by Libo on 17/5/5.
//  Copyright © 2017年 iDress. All rights reserved.
//  食材数据库，食材专用。没有依赖FMDB。整个工程就食材一处用到数据库，没必要依赖第三方

#import <Foundation/Foundation.h>

@interface ZCIngredientSqlite : NSObject

+ (instancetype)shareSqlite;

/**
 *  创建表
 */
- (BOOL)creatTableWithTableName:(NSString *)tableName;

/**
 *  保存数据
 */
- (BOOL)saveToTable:(NSString *)tableName dictArray:(NSArray *)dictArray;

/**
 *  取出所有数据
 */
- (NSArray *)queryAllDataOnTable:(NSString *)tableName;

/**
 *  取出单条数据
 */
- (NSDictionary *)queryOneData:(NSString *)tableName dic_id:(NSString *)dic_id;

@end
