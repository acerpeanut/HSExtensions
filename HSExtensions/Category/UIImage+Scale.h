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

/**
 缩放到指定大小

 @param newSize 新图片的分辨率
 @return 新图片
 */
- (UIImage *)scaleToSize:(CGSize)newSize;

/**
 按比例缩放，最大不超过指定大小

 @param maxSize 新图片 宽x高 的最大值
 @return 新图片
 */
- (UIImage *)scaleToMaxSize:(CGFloat)maxSize;

/**
 按比例缩放，压缩图片，并转换成NSData

 @param maxSize 新图片 宽x高 的最大值
 @param compressionQuality 图片压缩质量（0:最差 1:最好）
 @return 新图片的NSData
 */
- (NSData *)compressWithMaxSize:(CGFloat)maxSize compressionQuality:(CGFloat)compressionQuality;

@end
