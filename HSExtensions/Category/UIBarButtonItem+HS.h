//
//  UIBarButtonItem+HS.h
//  09-21-01-新浪微博
//
//  Created by peanut on 15/9/22.
//  Copyright (c) 2015年 peanut. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (HS)

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;

@end
