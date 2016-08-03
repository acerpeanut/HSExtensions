//
//  HSVerticalButton.m
//  UnionpayDemo
//
//  Created by viewat on 16/8/3.
//  Copyright © 2016年 viewat. All rights reserved.
//

#import "HSVerticalButton.h"

@implementation HSVerticalButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat height = self.imageSize.height;
    CGFloat width = self.imageSize.width;
    CGFloat x = (contentRect.size.width - width)/2;
    
    CGRect imageRect = CGRectMake(x, 3, width, height);
    return imageRect;
}

- (CGSize)imageSize {
    if (self.currentImage) {
        return CGSizeMake(self.currentImage.size.width, self.currentImage.size.height);
    }
    return CGSizeZero;
}

- (UIFont *)titleFont {
    UIFont *font = self.titleLabel.font;
    if (font == nil) {
        font = [UIFont systemFontOfSize:16];
    }
    return font;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat height = contentRect.size.height-self.imageSize.height-3;
    CGSize size = [self.currentTitle boundingRectWithSize:CGSizeMake(contentRect.size.width, contentRect.size.height-self.imageSize.height) options:0 attributes:@{NSFontAttributeName:self.titleFont} context:nil].size;
    
    CGFloat y = self.imageSize.height-3;
    CGFloat x = (contentRect.size.width - size.width)/2;

    CGRect titleRect = CGRectMake(x, y, size.width, height);
    return titleRect;
}

@end
