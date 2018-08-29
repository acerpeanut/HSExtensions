//
//  NSDate+HS.h
//  09-24-01-新浪微博
//
//  Created by peanut on 15/9/26.
//  Copyright (c) 2015年 peanut. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HS)

/**
 *  是不是今天
 */
- (BOOL)isToday;

/**
 *  是不是昨天
 */
- (BOOL)isYesterday;

/**
 *  是不是今年
 */
- (BOOL)isThisYear;

/**
 *  与当前时间的间隔
 */
- (NSDateComponents *)deltaWithNow;

/**
 *  转换为字符串
 *
 *  @param dateFormat 格式控制
 *
 *  @return 字符串
 */
- (NSString *)stringWithDateFormat:(NSString *)dateFormat;

/**
 字符串转化为NSDate对象

 @param dateString 日期字符串
 @param format 日期格式
 @return NSDate对象
 */
+ (NSDate *)dateWithDateString:(NSString *)dateString format:(NSString *)format;

/**
 更新日期部件

 @param unit 年/月/日等等
 @param value value
 @return 新的日期
 */
- (NSDate *)dateByAddingUnit:(NSCalendarUnit)unit value:(NSInteger)value;

@end
