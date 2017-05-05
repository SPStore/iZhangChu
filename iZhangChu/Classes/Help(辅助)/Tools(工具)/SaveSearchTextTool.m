//
//  SavesaveTextTool.m
//  iDress
//
//  Created by leshengping on 16/9/14.
//  Copyright © 2016年 Canye. All rights reserved.
//

#define ZCRecentTextPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"searchText.archive"]

#import "SaveSearchTextTool.h"

@implementation SaveSearchTextTool


static NSMutableArray *_saveTextArray;

+ (void)initialize {
    
    _saveTextArray = [NSKeyedUnarchiver unarchiveObjectWithFile:ZCRecentTextPath];
    if (_saveTextArray == nil) {
        _saveTextArray = [NSMutableArray array];
    }
}

+ (void)saveRecentSearchText:(NSString *)text {
    
    if ([self isEmpty:text]) {
        return;
    }
    // 如果saveTextArray不包含搜索字符串,则添加到数组中去
    if (![_saveTextArray containsObject:text]) {
        [_saveTextArray insertObject:text atIndex:0];
    } else {
        [_saveTextArray removeObject:text];
        [_saveTextArray insertObject:text atIndex:0];
    }
    if (_saveTextArray.count > 6) {
        [_saveTextArray removeLastObject];
    }
    
    // 将所有的表情数据写入沙盒
    [NSKeyedArchiver archiveRootObject:_saveTextArray toFile:ZCRecentTextPath];
}

/**
 *  返回装着title的数组
 */
+ (NSArray *)fectchSaveTextArray {
    
    return _saveTextArray;
}

//判断是否全是空格
+ (BOOL) isEmpty:(NSString *) str {
    if (!str) {
        return true;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}

@end
