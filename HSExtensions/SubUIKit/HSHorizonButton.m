//
//  HSHorizonButton.m
//  UnionpayDemo
//
//  Created by viewat on 16/7/21.
//  Copyright © 2016年 viewat. All rights reserved.
//

#import "HSHorizonButton.h"

@implementation HSHorizonButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGRect imageRect = CGRectMake(5, (contentRect.size.height-20)/2, 20, 20);
    return imageRect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGRect titleRect = CGRectMake(30, (contentRect.size.height-20)/2, contentRect.size.width-30, 20);
    return titleRect;
}

@end
