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

- (UIImage *)scaleToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)scaleToMaxSize:(CGFloat)maxSize {
    CGFloat currentSize = self.size.width * self.size.height;
    if (currentSize > maxSize) {
        CGFloat delta = sqrt(maxSize/currentSize);
        CGSize fitSize = CGSizeMake(self.size.width * delta , self.size.height * delta);
        return [self scaleToSize:fitSize];
    }
    return self;
}

- (NSData *)compressWithMaxSize:(CGFloat)maxSize compressionQuality:(CGFloat)compressionQuality {
    UIImage *newImage = [self scaleToMaxSize:maxSize];
    if (newImage == nil) {
        return nil;
    }
    return UIImageJPEGRepresentation(newImage, compressionQuality);
}

@end
