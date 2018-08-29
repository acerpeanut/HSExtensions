//
//  WCImagePicker.h
//  WarmCar
//
//  Created by admin  on 2018/1/12.
//  Copyright © 2018年 GangQinPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WCImagePicker : NSObject

@property (nonatomic, strong) NSString *title;

/**
 是否允许选择视频(默认为NO)
 */
@property (nonatomic, assign) BOOL allowVideo;

/**
 是否允许相册(默认为YES)
 */
@property (nonatomic, assign) BOOL allowLibrary;

/**
 实例化选择图片弹框对象

 @param title 选择框标题
 @return 实例化对象
 */
- (instancetype)initWithTitle:(NSString *)title NS_DESIGNATED_INITIALIZER;

/**
 展示选择照片或图片的选择框
 
 @param vc 当前的控制器
 */
- (void)showPhotoActionSheetInVC:(UIViewController *)vc finish:(void (^)(UIImage * _Nonnull image))finsh;

/**
 将图片保存到 ImageFile 目录下

 @param image 要保存的图片
 @param fileName 保存后的文件名
 @return 保存是否成功
 */
+ (BOOL)saveToDocument:(UIImage *)image name:(NSString *)fileName;

@end
