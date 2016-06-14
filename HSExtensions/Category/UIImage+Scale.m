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
    
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *graphicsImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return graphicsImage;
    
}
@end
