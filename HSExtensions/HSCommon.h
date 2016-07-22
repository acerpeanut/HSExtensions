//
//  HSCommon.h
//
//  Created by peanut on 15/10/2.
//  Copyright (c) 2015年 peanut. All rights reserved.
//

#ifndef _9_24_01______HSCommon_h
#define _9_24_01______HSCommon_h


#define iOS8 ( [[UIDevice currentDevice].systemVersion doubleValue] >= 8.0 )

/**
 *  颜色设置
 */
#define HSColor(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]

/**
 *  自定义打印函数(##：当后面没参数时，会删掉前面的,)
 */
#ifdef DEBUG
#define HSLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define HSLog(...)
#endif


/**
 *  方法打印函数
 */
#define HSCMDLog  HSLog(@"[%s:%d]", __PRETTY_FUNCTION__, __LINE__);

#ifndef __NSX_PASTE__
#define __NSX_PASTE__(A,B) A##B
#endif

#define HSAssertReturn(a, b) ({  \
                __typeof__(a) __NSX_PASTE__(_a,__COUNTER__) = (a); \
                __typeof__(b) __NSX_PASTE__(_b,__COUNTER__) = (b); \
                if(__NSX_PASTE__(_a,__COUNTER__) != __NSX_PASTE__(_b,__COUNTER__) ) { \
                    NSLog(@"%@ -> %@", @#a, @(__NSX_PASTE__(_a,__COUNTER__))); \
                } \
                __NSX_PASTE__(_a,__COUNTER__); \
            })
#define HSAssertReturn0(a) HSAssertReturn(a,0)
#define HSAssertFalse(a) HSAssertReturn0(a)


/**
 * 在主线程执行
 */
void hs_runOnMainThread(void (^block)());

#define deallocDebugImplemention \
     - (void)dealloc { \
        NSLog(@"%@ dealloc", self); \
     }

// 版本号键
#define kBundleVersion @"CFBundleVersion"

// weakify and strongify
#ifndef    weakify
#if __has_feature(objc_arc)

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x; \
_Pragma("clang diagnostic pop")

#else

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __block __typeof__(x) __block_##x##__ = x; \
_Pragma("clang diagnostic pop")

#endif
#endif

#ifndef    strongify
#if __has_feature(objc_arc)

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __weak_##x##__; \
_Pragma("clang diagnostic pop")

#else

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __block_##x##__; \
_Pragma("clang diagnostic pop")

#endif
#endif

#endif
