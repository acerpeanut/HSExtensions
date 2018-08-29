//
//  NSArray+Log.m
//  DaJuQY
//
//  Created by GangQinPeng on 12/4/2017.
//  Copyright © 2017 GangQinPeng. All rights reserved.
//

#import "NSArray+Log.h"

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale {
    // 默认打印成json格式
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        @try {
            NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
            NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if (jsonStr) {
                if ([jsonStr rangeOfString:@"\\"].location != NSNotFound) { // 把 \\和\/ 转成 \和/
                    error = nil;
                    NSString *pattern = @"\\\\([\\\\/])";
                    NSRegularExpression *exp = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
                    NSRange range = NSMakeRange(0, jsonStr.length);
                    NSString *resultStr = [exp stringByReplacingMatchesInString:jsonStr options:0 range:range withTemplate:@"$1"];
                    if (!(error || resultStr.length == 0)) {
                        jsonStr = resultStr;
                    }
                }
                return jsonStr;
                
            }
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    
    NSMutableString *string = [NSMutableString string];
    // 开头有个[
    [string appendString:@"[\n"];
    
    // 遍历所有的元素
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         [string appendFormat:@"\t%@,\n", obj];
     }];
    
    // 结尾有个]
    [string appendString:@"]"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    
    if (range.location != NSNotFound) [string deleteCharactersInRange:range];
    
    return string;
}

@end

