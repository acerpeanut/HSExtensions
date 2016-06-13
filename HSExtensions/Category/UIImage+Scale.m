//
//  UIImage+Scale.m
//  webBrowserTest
//
//  Created by viewat on 16/4/6.
//  Copyright © 2016年 acerpeanut. All rights reserved.
//

#import "UIImage+Scale.h"

@implementation UIImage (Scale)

- (UIImage *)scaleImage {

    return [self scaleImageWithLeft:0.5 top:0.5];

}

- (UIImage *)scaleImageWithLeft:(CGFloat)left top:(CGFloat)top {
    return [self stretchableImageWithLeftCapWidth:(int)self.size.width*left topCapHeight:self.size.height*top];
}

+ (UIImage *)captureView:(UIView *)view {
    CGSize viewSize = view.bounds.size;
    CGContextRef bitmapcontext = CGBitmapContextCreate(NULL, viewSize.width, viewSize.height, 8, viewSize.width * 4, CGColorSpaceCreateDeviceRGB(), 1);
    
    // "drawInContext:" may not work in all views
    [view.layer renderInContext:bitmapcontext];
    
    CGImageRef imageRef = CGBitmapContextCreateImage(bitmapcontext);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    
    return image;
}
@end
