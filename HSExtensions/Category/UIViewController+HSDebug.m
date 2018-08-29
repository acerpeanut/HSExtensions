//
//  UIViewController+HSDebug.m
//  WarmCar
//
//  Created by admin  on 2017/12/8.
//  Copyright © 2017年 GangQinPeng. All rights reserved.
//

#import "UIViewController+HSDebug.h"
#import "NSObject+HSRuntime.h"

@implementation UIViewController (HSDebug)

#if defined(DEBUG) || defined(RELEASEBETA)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController hs_swizzleMethod:@selector(hs_viewDidLoad) withMethod:@selector(viewDidLoad)];
        [UIViewController hs_swizzleMethod:@selector(hs_viewWillAppear:) withMethod:@selector(viewWillAppear:)];
        [UIViewController hs_swizzleMethod:@selector(hs_viewWillDisappear:) withMethod:@selector(viewWillDisappear:)];
    });
}
- (void)hs_viewDidLoad {
    NSLog(@"lifeCycle: [%@ viewDidLoad]", NSStringFromClass([self class]));
    [self hs_viewDidLoad];
}
- (void)hs_viewWillAppear:(BOOL)animated {
    NSLog(@"lifeCycle: [%@ viewWillAppear]", NSStringFromClass([self class]));
    [self hs_viewWillAppear:animated];
}
- (void)hs_viewWillDisappear:(BOOL)animated {
    NSLog(@"lifeCycle: [%@ viewWillDisappear]", NSStringFromClass([self class]));
    [self hs_viewWillDisappear:animated];
}

#endif

@end


@implementation UIApplication (HSDebug)
#if defined(DEBUG) || defined(RELEASEBETA)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIApplication hs_swizzleMethod:@selector(hs_sendAction:to:from:forEvent:) withMethod:@selector(sendAction:to:from:forEvent:)];
    });
}
- (BOOL)hs_sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event {
    if ([NSStringFromClass([event class]) containsString:@"Touch"]) {
        NSLog(@"touch: -[%@ %@]", NSStringFromClass([target class]), NSStringFromSelector(action));
    } else {
        NSLog(@"--- untouch: -[%@ %@]", NSStringFromClass([target class]), NSStringFromSelector(action));
    }
    
    return [self hs_sendAction:action to:target from:sender forEvent:event];
}
#endif
@end
