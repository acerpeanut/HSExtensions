//
//  UIBarButtonItem+HS.m
//  09-21-01-新浪微博
//
//  Created by peanut on 15/9/22.
//  Copyright (c) 2015年 peanut. All rights reserved.
//

#import "UIBarButtonItem+HS.h"

@implementation UIBarButtonItem (HS)

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.bounds = (CGRect){ CGPointZero, button.currentBackgroundImage.size };
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}
@end
