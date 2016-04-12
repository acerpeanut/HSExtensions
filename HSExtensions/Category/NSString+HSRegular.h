//
//  NSString+HSRegular.h
//  webBrowserTest
//
//  Created by acerpeanut on 15/11/26.
//  Copyright © 2015年 acerpeanut. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HSRegular)

- (NSString *)stringByRegularReplacedWithPattern:(NSString *)pattern template:(NSString *)templateString;

/**
 *  转换字典或数组为json格式的字符串
 */
+ (NSString*)jsonStringWithObject:(id)object;

@end
