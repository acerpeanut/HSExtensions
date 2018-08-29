//
//  NSArray+WCSafe.m
//  WarmCar
//
//  Created by admin  on 2018/4/8.
//  Copyright © 2018年 GangQinPeng. All rights reserved.
//

#import "NSArray+WCSafe.h"

@implementation NSArray (WCSafe)

- (id)wc_objectAtIndex:(NSInteger)index {
    if (self.count <= index) {
        return nil;
    }
    return [self objectAtIndex:index];
}

@end
