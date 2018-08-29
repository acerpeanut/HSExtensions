//
//  WCThemeStyle.m
//  WarmCar
//
//  Created by admin  on 2018/3/15.
//  Copyright © 2018年 GangQinPeng. All rights reserved.
//

#import "WCThemeStyle.h"

UIColor *RGBA(CGFloat r, CGFloat g, CGFloat b, CGFloat a) {
    if (@available(iOS 10, *)) {
        return [UIColor colorWithDisplayP3Red:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a];
    } else {
        return [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a];
    }
}

UIColor *RGB(CGFloat r, CGFloat g, CGFloat b) {
    return RGBA(r, g, b, 1.0);
}

UIColor *HexColor(NSString *hexColor) {
    NSString *cString = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return RGB(r, g, b);
}

@implementation WCThemeStyle

@end
