//
//  SaveSearchTextTool.h
//  iDress
//
//  Created by leshengping on 16/9/14.
//  Copyright © 2016年 Canye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveSearchTextTool : NSObject

+ (void)saveRecentSearchText:(NSString *)text;

+ (NSArray *)fectchSaveTextArray;

@end
