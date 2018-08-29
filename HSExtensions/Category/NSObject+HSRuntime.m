//
//  NSObject+HSRuntime.m
//  WarmCar
//
//  Created by admin  on 2017/12/8.
//  Copyright © 2017年 GangQinPeng. All rights reserved.
//

#import "NSObject+HSRuntime.h"

#import <objc/runtime.h>

@implementation NSObject (HSRuntime)
+ (void)hs_swizzleMethod:(SEL)originSelector withMethod:(SEL)replaceSelector {
    
    Class clazz = [self class];
    
    SEL originSel = originSelector;
    SEL replaceSel = replaceSelector;
    
    Method originMethod = class_getInstanceMethod(clazz, originSel);
    Method replaceMethod = class_getInstanceMethod(clazz, replaceSel);
    
    // 因为现在是两个方法都在同一个类里，所以显得这一步没有必要
    BOOL didAddMethod =
    class_addMethod(clazz,
                    replaceSel,
                    method_getImplementation(replaceMethod),
                    method_getTypeEncoding(replaceMethod));
    
    if (didAddMethod) {
        class_replaceMethod(clazz,
                            replaceSel,
                            method_getImplementation(originMethod),
                            method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, replaceMethod);
    }
    
}
@end
