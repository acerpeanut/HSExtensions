//
//  NSArray+WCSafe.h
//  WarmCar
//
//  Created by admin  on 2018/4/8.
//  Copyright © 2018年 GangQinPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray<__covariant ObjectType> (WCSafe)

- (nullable ObjectType)wc_objectAtIndex:(NSInteger)index;

@end
