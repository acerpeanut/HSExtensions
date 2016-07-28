//
//  UITextView+HSPlaceHolder.m
//  UnionpayDemo
//
//  Created by viewat on 16/7/28.
//  Copyright © 2016年 viewat. All rights reserved.
//

#import "UITextView+HSPlaceHolder.h"

#import <objc/runtime.h>
#import <Masonry/Masonry.h>


@implementation UITextView (HSPlaceHolder)

static char kPlaceHolderKey;
- (UILabel *)placeHolderLabel {
    UILabel *placeHolderLabel = objc_getAssociatedObject(self, &kPlaceHolderKey);
    if (placeHolderLabel == nil) {
        placeHolderLabel = [UILabel new];
        placeHolderLabel.textColor = [UIColor colorWithRed:154.0/255 green:154.0/255 blue:154.0/255 alpha:1];
        [self addSubview:placeHolderLabel];
        objc_setAssociatedObject(self, &kPlaceHolderKey, placeHolderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self).insets(UIEdgeInsetsMake(4,8,0,0));
        }];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hs_textChange:) name:UITextViewTextDidChangeNotification object:self];
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

- (void)hs_textChange:(NSNotification *)notification {
    if (self.text.length) {
        self.placeHolderLabel.hidden = YES;
    } else {
        self.placeHolderLabel.hidden = NO;
    }
}


@end
