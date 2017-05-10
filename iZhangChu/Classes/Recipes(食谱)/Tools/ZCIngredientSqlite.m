//
//  ZCIngredientSqlite.m
//  iZhangChu
//
//  Created by Libo on 17/5/5.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCIngredientSqlite.h"
#import <sqlite3.h> // 需要导入libsqlite3.tbd类库

static sqlite3 *db;

@implementation ZCIngredientSqlite

// 单例
+ (instancetype)shareSqlite {
    static ZCIngredientSqlite *sqlite = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sqlite = [[ZCIngredientSqlite alloc] init];
    });
    return sqlite;
}

// 数据库文件路径
- (NSString *)dbPath {
    NSString * path = [[NSSearchPathForDirectoriesInDomains(13, 1, 1)lastObject]stringByAppendingPathComponent:@"ingredient.sqlite"];
    return path;
}

// 打开数据库
-(BOOL)openDB {

    if (sqlite3_open([[self dbPath] UTF8String], &db) == SQLITE_OK) { //根据指定目录打开数据库文件，如果没有就创建一个新的
        NSLog(@"打开数据库成功");
        return YES;
    } else {
        sqlite3_close(db);
        NSLog(@"打开数据库失败");
        return NO;
        
    }
}

// 创建表
- (BOOL)creatTableWithTableName:(NSString *)tableName {
    
    BOOL open = [self openDB]; // 打开数据库
    
    if (open) { // 如果打开数据库成功
        // 创建SQL语句
        // id:默认主键，依次从1开始自增1
        // dic_id:字典的id  text类型（NSString）
        // dic:字典  blob类型(NSData)
        NSString *createSQL = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(id INTEGER PRIMARY KEY AUTOINCREMENT,dic_id text,dic blob NOT NULL);", tableName];
        char *erroMsg;
        if (sqlite3_exec(db, [createSQL UTF8String], NULL, NULL, &erroMsg) != SQLITE_OK) {
            NSLog(@"创建表失败");
            sqlite3_close(db);
            return NO;
        } else {
            NSLog(@"创建表成功");
            return YES;
        }
    }
    return NO;
}

// 保存
- (BOOL)saveToTable:(NSString *)tableName dictArray:(NSArray *)dictArray {
    
    BOOL open = [self openDB]; // 打开数据库
    
    if (open) { // 如果打开数据库成功
        
        BOOL flag = false; // 标记下面这个for循环是否每次遍历都成功
        
        for (NSDictionary *dict in dictArray) {
            
            // 根据字典中的id，在数据库中查询有没有此id对应的字典，如果有，就不需要存储一样的字典
            // 这是解决外界不小心多次调用了这个方法导致重复添加数据的问题
            NSDictionary *oneDict = [self queryOneData:tableName dic_id:dict[@"id"]];
            if ([dict isEqualToDictionary:oneDict]) { // 如果从数据库中取出来的字典与即将保存的字典一致，说明该字典已经存在，直接retun
                return NO;
            }
            
            // 把字典对象序列化成NSData二进制数据
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
            
            // 指令集
            sqlite3_stmt *stmt;
 
            // 创建保存到数据库的SQL语句
            NSString *saveSql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@(dic_id,dic) VALUES (?,?);",tableName];
            
            if (sqlite3_prepare_v2(db, saveSql.UTF8String, -1, &stmt, nil) == SQLITE_OK) { // 语法通过
                
                NSString *dic_id = dict[@"id"];
                
                // 第一个参数:指令集，也叫跟随指针
                // 第二个参数:对应表中第几列
                // 第三个参数:需要保存的内容
                // 第四个参数:内容大小，－1为无限长
                // 第五个参数:NULL
                sqlite3_bind_text(stmt, 1, dic_id.UTF8String, -1, NULL);
                sqlite3_bind_blob64(stmt, 2, [data bytes], [data length], NULL);
                
                int step = sqlite3_step(stmt);
                
                if (step == SQLITE_DONE) {
                    flag = 1; // 不要在这里直接return YES，否则不会继续遍历
                } else {
                    flag = 0;
                    NSLog(@"此条数据保存失败,失败原因:%d",step);
                    break; // 只要有一条数据保存失败，则规定所有数据保存失败，跳出循环
                }
            }
            // 释放指令集
            sqlite3_finalize(stmt);
        }
        if (1 == flag) {
            NSLog(@"数据全部保存成功");
        }
   
        // 关闭数据库
        sqlite3_close(db);  // 关闭了数据库，下次使用就一定要记得打开
    }
    return NO;
}

// 查询所有数据
- (NSArray *)queryAllDataOnTable:(NSString *)tableName {
    
    BOOL open = [self openDB]; // 打开数据库
    
    if (open) {  // 如果代开数据库成功
        
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM %@",tableName];
        
        sqlite3_stmt * stmt;
        
        if (sqlite3_prepare_v2(db, querySQL.UTF8String, -1, &stmt, nil) == SQLITE_OK) { // 语法通过
            NSMutableArray *dictArray = [NSMutableArray array];
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                
                // 下面三行参考了FMDB框架内部的写法
                int dataSize = sqlite3_column_bytes(stmt, 2);
                const char *dataBuffer = sqlite3_column_blob(stmt, 2);
                NSData *data = [NSData dataWithBytes:(const void *)dataBuffer length:(NSUInteger)dataSize];
                // 将NSData转成字典
                NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                
                [dictArray addObject:dict];
            }
            return dictArray;
        }
        // 释放指令集
        sqlite3_finalize(stmt);
        // 关闭数据库
        sqlite3_close(db);
    }
    return nil;
}

// 查询单条数据
- (NSDictionary *)queryOneData:(NSString *)tableName dic_id:(NSString *)dic_id {
    BOOL open = [self openDB]; // 打开数据库
    
    if (open) {  // 如果代开数据库成功
        
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE dic_id = %@",tableName,dic_id];
        
        sqlite3_stmt * stmt;
        
        if (sqlite3_prepare_v2(db, querySQL.UTF8String, -1, &stmt, nil) == SQLITE_OK) { // 语法通过
            NSDictionary *tempDic;
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                
                // 根据dic_id取出对应的字典
                // 下面三行参考了FMDB框架内部的写法
                int dataSize = sqlite3_column_bytes(stmt, 2);
                const char *dataBuffer = sqlite3_column_blob(stmt, 2);
                NSData *data = [NSData dataWithBytes:(const void *)dataBuffer length:(NSUInteger)dataSize];
                // 将NSData转成字典
                tempDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            }
            return tempDic;
        }
        // 释放指令集
        sqlite3_finalize(stmt);
        // 关闭数据库
        sqlite3_close(db);
    }
    return nil;
}

@end
