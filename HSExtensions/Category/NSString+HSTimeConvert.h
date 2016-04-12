//
//  NSString+HSTimeConvert.h
//  webBrowserTest
//
//  Created by acerpeanut on 15/11/26.
//  Copyright © 2015年 acerpeanut. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HSTimeConvert)

- (NSDate *)unConvert;

/**
 *  转换新浪的created_at为日期
 */
- (NSDate *)unConvertWithCreateAt;
@end
