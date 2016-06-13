//
//  NSString+HSTimeConvert.m
//  webBrowserTest
//
//  Created by acerpeanut on 15/11/26.
//  Copyright © 2015年 acerpeanut. All rights reserved.
//

#import "NSString+HSTimeConvert.h"
#import "NSString+HSRegular.h"

@implementation NSString (HSTimeConvert)

/**
 *  改变当前时间的部分部件
 *
 *  @param dateFormat 日期格式
 *  @param uint       部件部分
 *
 *  @return 改变后的时间
 */
- (NSDate *)updateComponentsWithDateFormat:(NSString *)dateFormat calendarUnit:(NSInteger)uint
{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"us_EN"];
    fmt.dateFormat = dateFormat;
    NSDate *newDate = [fmt dateFromString:self];
    
    if (newDate == nil) {
        return nil;
    }
    
    
    
    // 今日
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int fullUint = NSCalendarUnitEra | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *nowCmps = [calendar components:fullUint fromDate:date];
    
    // 这个时刻
    NSCalendar *timeCalendar = [NSCalendar currentCalendar];
    NSDateComponents *timeCmps = [timeCalendar components:uint fromDate:newDate];
    if (uint & NSCalendarUnitEra) {
        [nowCmps setValue:timeCmps.era forComponent:NSCalendarUnitEra];
    }
    if (uint & NSCalendarUnitDay) {
        [nowCmps setValue:timeCmps.day forComponent:NSCalendarUnitDay];
    }
    if (uint & NSCalendarUnitMonth) {
        [nowCmps setValue:timeCmps.month forComponent:NSCalendarUnitMonth];
    }
    if (uint & NSCalendarUnitYear) {
        [nowCmps setValue:timeCmps.year forComponent:NSCalendarUnitYear];
    }
    if (uint & NSCalendarUnitHour) {
        [nowCmps setValue:timeCmps.hour forComponent:NSCalendarUnitHour];
    }
    if (uint & NSCalendarUnitMinute) {
        [nowCmps setValue:timeCmps.minute forComponent:NSCalendarUnitMinute];
    }
    
    date = [calendar dateFromComponents:nowCmps];
    return date;
}

/**
 *  逆转时间
 *
 *  @return 逆转后的时间
 */
- (NSDate *)unConvert
{
    NSDate *date = nil;
    
    if ([self isEqualToString:@"刚刚"]) {
        
        date = [NSDate date];
        
    } else if ([self containsString:@"分钟前"]) {
        
        NSString *newString = [self stringByRegularReplacedWithPattern:@"分钟前" template:@""];
        NSInteger subCount = [newString intValue]*(-60);
        date = [[NSDate alloc] initWithTimeInterval:subCount sinceDate:[NSDate date]];

    } else if ([self containsString:@"今天"]) {
        
        NSString *newString = [self stringByRegularReplacedWithPattern:@"今天 ?" template:@""];

        date = [newString updateComponentsWithDateFormat:@"HH:mm" calendarUnit:NSCalendarUnitHour|NSCalendarUnitMinute];
        
    } else if ([self containsString:@"月"]) {
        
        date = [self updateComponentsWithDateFormat:@"MM月dd日 HH:mm" calendarUnit:NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute];
        
    } else {
        
        date = [self updateComponentsWithDateFormat:@"MM-dd HH:mm" calendarUnit:NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute];
        
        if (date == nil) {
            date = [self updateComponentsWithDateFormat:@"yyyy-MM-dd HH:mm" calendarUnit:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute];
        }
        
    }
    
    if (date == nil) {
        date = [NSDate date];
    }
    return date;
}

/**
 *  转换新浪的created_at为日期
 */
- (NSDate *)unConvertWithCreateAt
{
    NSDate *date = [self updateComponentsWithDateFormat:@"EEE MMM dd HH:mm:ss xx yyyy" calendarUnit:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitTimeZone|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond];
    return date;
}
@end
