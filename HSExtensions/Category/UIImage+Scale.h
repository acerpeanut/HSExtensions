//
//  UIImage+Scale.h
//  webBrowserTest
//
//  Created by viewat on 16/4/6.
//  Copyright © 2016年 acerpeanut. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scale)

- (UIImage *)scaleImage;

- (UIImage *)scaleImageWithLeft:(CGFloat)left top:(CGFloat)top;

+ (UIImage *)captureView:(UIView *)view;

@end
