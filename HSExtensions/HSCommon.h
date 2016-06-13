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

/**
 * 在主线程执行
 */
void hs_runOnMainThread(void (^block)());


// 版本号键
#define kBundleVersion @"CFBundleVersion"



#endif
