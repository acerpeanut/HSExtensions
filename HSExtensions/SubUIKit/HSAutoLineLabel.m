//
//  HSAutoLineLabel.m
//  UnionpayDemo
//
//  Created by viewat on 16/7/15.
//  Copyright © 2016年 viewat. All rights reserved.
//

#import "HSAutoLineLabel.h"

@implementation HSAutoLineLabel

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    self.preferredMaxLayoutWidth = size.width;
    
    [self layoutIfNeeded];
}

@end
