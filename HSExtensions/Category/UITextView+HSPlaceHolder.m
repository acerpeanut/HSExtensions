//
//  UITextView+HSPlaceHolder.m
//  UnionpayDemo
//
//  Created by viewat on 16/7/28.
//  Copyright © 2016年 viewat. All rights reserved.
//

#import "UITextView+HSPlaceHolder.h"

#import <objc/runtime.h>

@implementation UITextView (HSPlaceHolder)

static char kPlaceHolderKey;
- (UILabel *)placeHolderLabel {
    
    UILabel *placeHolderLabel = objc_getAssociatedObject(self, &kPlaceHolderKey);
    if (placeHolderLabel == nil) {
        placeHolderLabel = [self setupPlaceHolderLabel];
    }
    return placeHolderLabel;
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    self.placeHolderLabel.text = placeHolder;
}

- (NSString *)placeHolder {
    return self.placeHolderLabel.text;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UILabel *)setupPlaceHolderLabel {
    UILabel *placeHolderLabel = [UILabel new];
    placeHolderLabel.textColor = [UIColor colorWithRed:154.0/255 green:154.0/255 blue:154.0/255 alpha:1];
    placeHolderLabel.numberOfLines = 0;
    [self addSubview:placeHolderLabel];
    
    objc_setAssociatedObject(self, &kPlaceHolderKey, placeHolderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    placeHolderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:placeHolderLabel attribute:NSLayoutAttributeLeading multiplier:1.0 constant:-8];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:placeHolderLabel attribute:NSLayoutAttributeTop multiplier:1.0 constant:-4];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:placeHolderLabel attribute:NSLayoutAttributeWidth multiplier:1.0 constant:16];
    
    [self addConstraints:@[left, top, width]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hs_textChange:) name:UITextViewTextDidChangeNotification object:self];
    return placeHolderLabel;
}

- (void)hs_textChange:(NSNotification *)notification {
    if (self.text.length) {
        self.placeHolderLabel.hidden = YES;
    } else {
        self.placeHolderLabel.hidden = NO;
    }
}


@end
