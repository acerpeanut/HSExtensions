//
//  NSDate+HS.m
//  09-24-01-新浪微博
//
//  Created by peanut on 15/9/26.
//  Copyright (c) 2015年 peanut. All rights reserved.
//

#import "NSDate+HS.h"

@implementation NSDate (HS)

/**
 *  是不是今天
 */
- (BOOL)isToday
{
    // 取得当前日期
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    int uint = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    // 当前日期对应部分
    NSDateComponents *nowCmps = [calendar components:uint fromDate:now];
    
    // 待检测日期对应部分
    NSDateComponents *dateCmps = [calendar components:uint fromDate:self];
    
    return (nowCmps.year == dateCmps.year) &&
            (nowCmps.month == dateCmps.month) &&
            (nowCmps.day == dateCmps.day);
}


/**
 *  省略了时分秒的时间
 */
- (NSDate *)dateOfFloor
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"us_EN"];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *newDate = [fmt dateFromString:[fmt stringFromDate:self]];
    
    return newDate;
}

/**
 *  是不是昨天
 */
- (BOOL)isYesterday
{
    // 取得当前日期
    NSDate *now = [[NSDate date] dateOfFloor];
    
    NSDate *selfDate = [self dateOfFloor];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    int uint = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    // 从待检测日期到当前日期
    NSDateComponents *dateCmps = [calendar components:uint fromDate:selfDate toDate:now options:0];
    
    return dateCmps.year == 0 && dateCmps.month == 0 && dateCmps.day == 1;
}

/**
 *  是不是今年
 */
- (BOOL)isThisYear
{
    // 取得当前日期
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    int uint = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    // 当前日期对应部分
    NSDateComponents *nowCmps = [calendar components:uint fromDate:now];
    
    // 待检测日期对应部分
    NSDateComponents *dateCmps = [calendar components:uint fromDate:self];
    
    return (nowCmps.year == dateCmps.year);
}

/**
 *  与当前时间的间隔
 */
- (NSDateComponents *)deltaWithNow;
{
    // 取得当前日期
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    int uint = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute;
    
    // 从待检测日期到当前日期
    return [calendar components:uint fromDate:self toDate:now options:0];
}

/**
 *  转换为字符串
 *
 *  @param dateFormat 格式控制
 *
 *  @return 字符串
 */
- (NSString *)stringWithDateFormat:(NSString *)dateFormat
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"us_EN"];
    fmt.dateFormat = dateFormat;
    
    NSString *newString = [fmt stringFromDate:self];
    
    return newString;
}

/**
 字符串转化为NSDate对象
 
 @param dateString 日期字符串
 @param format 日期格式
 @return NSDate对象
 */
+ (NSDate *)dateWithDateString:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"us_EN"];
    fmt.dateFormat = format;
    
    NSDate *date = [fmt dateFromString:dateString];
    return date;
}

/**
 更新日期部件
 
 @param unit 年/月/日等等
 @param value value
 @return 新的日期
 */
- (NSDate *)dateByAddingUnit:(NSCalendarUnit)unit value:(NSInteger)value {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar dateByAddingUnit:unit value:value toDate:self options:NSCalendarMatchStrictly];
}

@end
