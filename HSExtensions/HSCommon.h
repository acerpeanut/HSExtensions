//
//  HSCommon.h
//  09-24-01-新浪微博
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
 *  自定义打印函数
 */
#ifdef DEBUG
#define HSLog(...) NSLog(__VA_ARGS__)
#else
#define HSLog(...)
#endif

//inline void errorLog(NSString *format, char *file, char *func, ...) {
//    NSString *formatComplete = [NSString stringWithFormat:@"[%s,%s]%@",  file, func ,format];
//    int sum=0;
//    va_list args;
//    va_start(args,n);
//    while(n>0)
//    {
//        //通过va_arg(args,int)依次获取参数的值
//        sum+=va_arg(args,int);
//        n--;
//    }
//    va_end(args);
//    return sum;
//}

#pragma mark - Home控制器的宏



/** 表格缝隙距离 */
#define paddingBorder 5

/** tabbar按钮的图片与文字的高度比例 */
#define kImageOriginFactor 0.6

/** home控制器导航栏的图片宽度 */
#define kTitleImageWidth 20

// 版本号键
#define kBundleVersion @"CFBundleVersion"



#endif
