//
//  HSAlertController.h
//  UnionpayDemo
//
//  Created by viewat on 16/7/5.
//  Copyright © 2016年 viewat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSAlertController : UIAlertController

@property (nonatomic, strong, readonly) UITextField *textField;

@property (nonatomic, copy) dispatch_block_t onCancel;
@property (nonatomic, copy) dispatch_block_t onConfirm;

/**
 * 带输入框的AlertController(有取消，有确定)
 */
+ (instancetype)alertControllerStyle1WithTitle:(NSString *)title message:(NSString *)message inputTextHandler:(void (^)(NSString *inputText))inputTextHandler;

/**
 * AlertController(有取消，有确定)
 */
+ (instancetype)alertControllerStyleDefaultWithTitle:(NSString *)title message:(NSString *)message;

@end
