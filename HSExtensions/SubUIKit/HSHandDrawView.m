//
//  HSHandDrawView.m
//  HSHUDHelper
//
//  Created by viewat on 16/6/13.
//  Copyright © 2016年 HS. All rights reserved.
//

#import "HSHandDrawView.h"

@implementation HSHandDrawView {
    CGMutablePathRef _path;
    CGMutablePathRef _subPath;
    
    UIImageView *_imageView;
}

- (UIImage *)saveViewToImage {
    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *graphicsImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return graphicsImage;
}

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
//    [[UIColor whiteColor] set];
//    CGContextFillRect(context, rect);
    
    [[UIColor blackColor] setStroke];
    
    CGContextSetLineWidth(context, 2);
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineJoin(context, kCGLineJoinBevel);
    CGContextAddPath(context, _path);
    
    if (_subPath) {
        CGContextAddPath(context, _subPath);
    }
    CGContextStrokePath(context);
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    
    if (_path == nil) {
        _path =  CGPathCreateMutable();
    }

    if (_subPath != nil) {
        CGPathRelease(_subPath);
        _subPath = nil;
        
    }
    _subPath = CGPathCreateMutable();
    

    CGPoint point = [touch locationInView:self];
    CGPathMoveToPoint(_subPath, &CGAffineTransformIdentity, point.x, point.y);
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    
    
    CGPoint point = [touch locationInView:self];

    CGPathAddLineToPoint(_subPath, &CGAffineTransformIdentity, point.x, point.y);
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0,0);
    CGPathAddPath(_path, &transform, _subPath);
    
    CGPathRelease(_subPath);
    _subPath = nil;
    
    [self setNeedsDisplay];
    
    
}

- (void)dealloc {
    if (_path) {
        CGPathRelease(_path);
    }
    if (_subPath) {
        CGPathRelease(_path);
    }
}

@end
