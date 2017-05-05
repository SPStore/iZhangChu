//
//  ZCIngredientsSqlite.h
//  iZhangChu
//
//  Created by Libo on 17/5/5.
//  Copyright © 2017年 iDress. All rights reserved.
//  食材数据库 

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@class ZCIngredientsDataModel;

#define kFilename  @"testdb.db"

@interface ZCIngredientsSqlite : NSObject {
    sqlite3 *_database;
    
}

@property (nonatomic) sqlite3 *_database;
-(BOOL) createTestList:(sqlite3 *)db;//创建数据库

-(BOOL) insertTestList:(ZCIngredientsDataModel *)model;//插入数据
-(BOOL) updateTestList:(ZCIngredientsDataModel *)model;//更新数据
-(NSMutableArray*)getAllData;//获取全部数据
- (BOOL) deleteTestList:(ZCIngredientsDataModel *)model;//删除数据：
- (NSMutableArray*)searchTestList:(NSString*)searchString;//查询数据库，searchID为要查询数据的ID，返回数据为查询到的数据
@end
