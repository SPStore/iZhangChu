//
//  TryResultCollectVC.h
//  iDress
//
//  Created by Shengping on 16/9/13.
//  Copyright © 2016年 Shengping. All rights reserved.
//

#import "SPSqlite.h"
#import <FMDB.h>

#define SQLITE_NAME @"BGSqlite.sqlite"

@interface SPSqlite ()

@property (nonatomic, strong) FMDatabaseQueue *queue;

@end

static SPSqlite* BGFmdb;

@implementation SPSqlite

- (instancetype)init{
    self = [super init];
    if (self) {
        // 获取沙盒中的数据库文件名
        NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:SQLITE_NAME];
        // 创建数据库队列
        self.queue = [FMDatabaseQueue databaseQueueWithPath:filename];
    }
    return self;
}

/**
 *  获取单例函数
 */
+ (instancetype)shareSqlite
{
    if (BGFmdb == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            BGFmdb = [[SPSqlite alloc] init];
        });
    }
    return BGFmdb;
}

/**
 *  数据库是否存在此表
 */
- (BOOL)isExistWithTableName:(NSString *)name{
    if (name == nil) {
        return NO;
    }
    __block BOOL result;
    [self.queue inDatabase:^(FMDatabase *db) {
        result = [db tableExists:name];
    }];
    return result;
}

/**
 *  创建表, 默认建立主键
 */
- (BOOL)createTableWithTableName:(NSString *)name keys:(NSArray *)keys{
    if (name == nil) {
        return NO;
    }else if (keys == nil){
        return NO;
    }else;
    __block BOOL result;
    [self.queue inDatabase:^(FMDatabase *db) {
        NSString* header = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement",name];//,name text,age integer);
        NSMutableString* sql = [[NSMutableString alloc] init];
        [sql appendString:header];
        for(int i=0;i<keys.count;i++){
            [sql appendFormat:@",%@ text",keys[i]];
            if (i == (keys.count-1)) {
                [sql appendString:@");"];
            }
        }
        result = [db executeUpdate:sql];
    }];
    return result;
}

/**
 *  插入值
 */
- (BOOL)insertIntoTableName:(NSString *)name Dict:(NSDictionary *)dict{
    
    if (name == nil) {
        return NO;
    }else if (dict == nil){
        return NO;//不能插入空数据
    }else;
    
    __block BOOL result;
    [self.queue inDatabase:^(FMDatabase *db) {
        NSArray* keys = dict.allKeys;
        NSMutableArray* values = dict.allValues.mutableCopy;
        NSMutableString* SQL = [[NSMutableString alloc] init];
        [SQL appendFormat:@"insert into %@(",name];
        for(int i=0;i<keys.count;i++){
            [SQL appendFormat:@"%@",keys[i]];
            if(i == (keys.count-1)){
                [SQL appendString:@") "];
            }else{
                [SQL appendString:@","];
            }
        }
        [SQL appendString:@"values("];
        for(int i=0;i<values.count;i++){
            id ttt = values[i];
            if ([ttt isKindOfClass:[NSArray class]]) {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:ttt];
                [values replaceObjectAtIndex:i withObject:data];
            }
            [SQL appendString:@"?"];
            if(i == (keys.count-1)){
                [SQL appendString:@");"];
            }else{
                [SQL appendString:@","];
            }
        }
        result = [db executeUpdate:SQL withArgumentsInArray:values];
    }];
    return result;
    
}

/**
 *  根据条件查询
 */
-(NSArray*)queryWithTableName:(NSString*)name keys:(NSArray*)keys where:(NSArray*)where;{
    if (name == nil) {
        return nil;
    }else if (keys == nil){
        return nil;
    }else;
    
    __block NSMutableArray* arrM = [[NSMutableArray alloc] init];
    [self.queue inDatabase:^(FMDatabase *db) {
        NSMutableString* SQL = [[NSMutableString alloc] init];
        [SQL appendString:@"select "];
        for(int i=0;i<keys.count;i++){
            [SQL appendFormat:@"%@",keys[i]];
            if (i != (keys.count-1)) {
                [SQL appendString:@","];
            }
        }
        [SQL appendFormat:@" from %@ where ",name];
        if ((where!=nil) && (where.count>0)){
            if(!(where.count%3)){
                for(int i=0;i<where.count;i+=3){
                    [SQL appendFormat:@"%@%@'%@'",where[i],where[i+1],where[i+2]];
                    if (i != (where.count-3)) {
                        [SQL appendString:@" and "];
                    }
                }
            }else{
                NSLog(@"条件数组错误!");
            }
        }
        // 1.查询数据
        FMResultSet *rs = [db executeQuery:SQL];
        // 2.遍历结果集
        while (rs.next) {
            NSMutableDictionary* dictM = [[NSMutableDictionary alloc] init];
            for(int i=0;i<keys.count;i++){
                dictM[keys[i]] = [rs stringForColumn:keys[i]];
            }
            [arrM addObject:dictM];
        }
    }];
    return arrM;
}

/**
 全部查询
 */
-(NSArray*)queryWithTableName:(NSString*)name{
    if (name==nil){
        return nil;
    }
    
    __block NSMutableArray* arrM = [[NSMutableArray alloc] init];
    [self.queue inDatabase:^(FMDatabase *db) {
        NSString* SQL = [NSString stringWithFormat:@"select * from %@",name];
        // 1.查询数据
        FMResultSet *rs = [db executeQuery:SQL];
        // 2.遍历结果集
        while (rs.next) {
            NSMutableDictionary* dictM = [[NSMutableDictionary alloc] init];
            for (int i=0;i<[[[rs columnNameToIndexMap] allKeys] count];i++) {
                if ([[rs objectForColumnIndex:i] isKindOfClass:[NSData class]]) {
                    NSArray *ddd = [NSKeyedUnarchiver unarchiveObjectWithData:[rs objectForColumnIndex:i]];
                    dictM[[rs columnNameForIndex:i]] = ddd;
                } else {
                    dictM[[rs columnNameForIndex:i]] = [rs stringForColumnIndex:i];

                }
                
            }
            [arrM addObject:dictM];
        }
    }];
    return arrM;
    
}

/**
 根据key更新value
 */
-(BOOL)updateWithTableName:(NSString*)name valueDict:(NSDictionary*)valueDict where:(NSArray*)where{
    if (name == nil) {
        return NO;
    }else if (valueDict == nil){
        return NO;
    }else;
    
    __block BOOL result;
    [self.queue inDatabase:^(FMDatabase *db) {
        NSMutableString* SQL = [[NSMutableString alloc] init];
        [SQL appendFormat:@"update %@ set ",name];
        for(int i=0;i<valueDict.allKeys.count;i++){
            [SQL appendFormat:@"%@='%@'",valueDict.allKeys[i],valueDict[valueDict.allKeys[i]]];
            if (i == (valueDict.allKeys.count-1)) {
                [SQL appendString:@" "];
            }else{
                [SQL appendString:@","];
            }
        }
        if ((where!=nil) && (where.count>0)){
            if(!(where.count%3)){
                [SQL appendString:@"where "];
                for(int i=0;i<where.count;i+=3){
                    [SQL appendFormat:@"%@%@'%@'",where[i],where[i+1],where[i+2]];
                    if (i != (where.count-3)) {
                        [SQL appendString:@" and "];
                    }
                }
            }else{
                NSLog(@"条件数组错误!");
            }
        }
        result = [db executeUpdate:SQL];
    }];
    return result;
}

/**
 删除
 */
-(BOOL)deleteWithTableName:(NSString*)name where:(NSArray*)where{
    if (name == nil) {
        return NO;
    }else if (where==nil || (where.count%3)){
        return NO;
    }else;
    
    __block BOOL result;
    [self.queue inDatabase:^(FMDatabase *db) {
        NSMutableString* SQL = [[NSMutableString alloc] init];
        [SQL appendFormat:@"delete from %@ where ",name];
        for(int i=0;i<where.count;i+=3){
            [SQL appendFormat:@"%@%@'%@'",where[i],where[i+1],where[i+2]];
            if (i != (where.count-3)) {
                [SQL appendString:@" and "];
            }
        }
        result = [db executeUpdate:SQL];
    }];
    return result;
}
/**
 根据表名删除表格全部内容
 */
-(BOOL)clearTable:(NSString *)name{
    if (name==nil){
        return NO;
    }
    __block BOOL result;
    [self.queue inDatabase:^(FMDatabase *db) {
        NSString* SQL = [NSString stringWithFormat:@"delete from %@;",name];
        result = [db executeUpdate:SQL];
    }];
    return result;
}

/**
 删除表
 */
-(BOOL)dropTable:(NSString*)name{
    if (name==nil){
        return NO;
    }
    __block BOOL result;
    [self.queue inDatabase:^(FMDatabase *db) {
        NSString* SQL = [NSString stringWithFormat:@"drop table %@;",name];
        result = [db executeUpdate:SQL];
    }];
    return result;
}











@end
