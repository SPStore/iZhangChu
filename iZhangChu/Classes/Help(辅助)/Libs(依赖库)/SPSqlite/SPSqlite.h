//
//  TryResultCollectVC.h
//  iDress
//
//  Created by Shengping on 16/9/13.
//  Copyright © 2016年 Shengping. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SPSqlite : NSObject


/**
 *  获取单例函数
 */
+ (instancetype)shareSqlite;

/**
 *  根据表名判断数据库是否存在该表
 */
- (BOOL)isExistWithTableName:(NSString *)name;

/**
 *  默认建立主键id
 *  创建表(如果存在就不创建) keys
 */
-(BOOL)createTableWithTableName:(NSString*)name keys:(NSArray*)keys;
/**
 插入 只关心key和value @{key:value,key:value}
 */
-(BOOL)insertIntoTableName:(NSString*)name Dict:(NSDictionary*)dict;
/**
 根据条件查询字段 返回的数组是字典( @[@{key:value},@{key:value}] ) ,where形式 @[@"key",@"=",@"value",@"key",@">=",@"value"]
 */
-(NSArray*)queryWithTableName:(NSString*)name keys:(NSArray*)keys where:(NSArray*)where;
/**
 全部查询 返回的数组是字典( @[@{key:value},@{key:value}] )
 */
-(NSArray*)queryWithTableName:(NSString*)name;
/**
 根据key更新value 形式 @[@"key",@"=",@"value",@"key",@">=",@"value"]
 */
-(BOOL)updateWithTableName:(NSString*)name valueDict:(NSDictionary*)valueDict where:(NSArray*)where;
/**
 根据表名和表字段删除表内容 where形式 @[@"key",@"=",@"value",@"key",@">=",@"value"]
 */
-(BOOL)deleteWithTableName:(NSString*)name where:(NSArray*)where;
/**
 根据表名删除表格全部内容
 */
-(BOOL)clearTable:(NSString*)name;
/**
 删除表
 */
-(BOOL)dropTable:(NSString*)name;






@end
