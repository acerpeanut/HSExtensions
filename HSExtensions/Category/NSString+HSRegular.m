//
//  NSString+HSRegular.m
//  webBrowserTest
//
//  Created by acerpeanut on 15/11/26.
//  Copyright © 2015年 acerpeanut. All rights reserved.
//

#import "NSString+HSRegular.h"

@implementation NSString (HSRegular)


- (NSString *)stringByRegularReplacedWithPattern:(NSString *)pattern template:(NSString *)templateString
{
    NSString *testString = self;
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    
    if (regex != nil) {
        // 3.....
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:testString
                                                             options:0
                                                               range:NSMakeRange(0, [testString length])];
        if (firstMatch) {
            NSString *result = [regex stringByReplacingMatchesInString:testString
                                                               options:0
                                                                 range:NSMakeRange(0, [testString length])
                                                          withTemplate:templateString];
            return result;
        }
    }
//    NSLog(@"什么都没改变: %@, %@", pattern, templateString);
    return self;
}

/**
 *  转换字典或数组为json格式的字符串
 */
+ (NSString*)jsonStringWithObject:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
@end
