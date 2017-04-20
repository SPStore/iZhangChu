//
//  Singleton.h
//  Singleton(MRC下)
//
//  Created by leshengping on 16/6/19.
//  Copyright © 2016年 leshengping. All rights reserved.
//

#ifndef Singleton_h
#define Singleton_h

#endif /* Singleton_h */


// 帮助实现单例设计模式（MRC下）

// .h文件的实现
#define SingletonH(methonName) + (instancetype)shared##methonName;

// .m文件的实现

#if __has_feature(objc_arc) // ARC

#define SingletonM(methonName) \
static id _instance = nil;\
\
+ (id)allocWithZone:(struct _NSZone *)zone {\
    if (_instance == nil) {\
        static dispatch_once_t onceToken;\
        dispatch_once(&onceToken, ^{\
        _instance = [super allocWithZone:zone];\
    });\
}\
    return _instance;\
}\
\
- (instancetype)init {\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
    _instance = [super init];\
    });\
    return _instance;\
}\
\
+ (instancetype)shared##methonName {\
return [[self alloc] init];\
}\
\
+ (id)copyWithZone:(NSZone *)zone {\
    return _instance;\
}\
\
+ (id)mutableCopyZone:(NSZone *)zone {\
    return _instance;\
}

#else  // 非ARC

#define SingletonM(methonName) \
static id _instance = nil;\
\
+ (id)allocWithZone:(struct _NSZone *)zone {\
    if (_instance == nil) {\
        static dispatch_once_t onceToken;\
        dispatch_once(&onceToken, ^{\
            _instance = [super allocWithZone:zone];\
        });\
    }\
    return _instance;\
}\
\
- (instancetype)init {\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _instance = [super init];\
    });\
    return _instance;\
}\
\
+ (instancetype)shared##methonName {\
    return [[self alloc] init];\
}\
\
- (oneway void)release {\
    \
}\
\
- (id)retain {\
    return self;\
}\
\
- (NSUInteger)retainCount {\
    return 1;\
}\
\
+ (id)copyWithZone:(NSZone *)zone {\
    return _instance;\
}\
\
+ (id)mutableCopyZone:(NSZone *)zone {\
    return _instance;\
}

#endif

