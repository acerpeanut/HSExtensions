//
//  WCThemeStyle.h
//  WarmCar
//
//  Created by admin  on 2018/3/15.
//  Copyright © 2018年 GangQinPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern UIColor *RGBA(CGFloat r, CGFloat g, CGFloat b, CGFloat a);
extern UIColor *RGB(CGFloat r, CGFloat g, CGFloat b);

/**
 把十六进制颜色值转换成颜色

 @param hexColor #c17b74 / 0xc17b74 / #C17B74 / 0XC17B74 / c17b74
 @return 转换后的颜色
 */
extern UIColor *HexColor(NSString *hexColor);

@interface WCThemeStyle : NSObject

@end
