//
//  NSObject+HSRuntime.h
//  WarmCar
//
//  Created by admin  on 2017/12/8.
//  Copyright © 2017年 GangQinPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HSRuntime)
+ (void)hs_swizzleMethod:(SEL)originSelector withMethod:(SEL)replaceSelector;
@end
