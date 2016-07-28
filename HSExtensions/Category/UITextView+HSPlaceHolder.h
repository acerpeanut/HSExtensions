//
//  UITextView+HSPlaceHolder.h
//  UnionpayDemo
//
//  Created by viewat on 16/7/28.
//  Copyright © 2016年 viewat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (HSPlaceHolder)
@property (nonatomic, strong, readonly) UILabel *placeHolderLabel;
@property (nonatomic, copy) NSString *placeHolder;
@end
