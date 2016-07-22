//
//  HSAlertController.h
//  UnionpayDemo
//
//  Created by viewat on 16/7/5.
//  Copyright © 2016年 viewat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSAlertController : UIAlertController

@property (nonatomic, strong) UITextField *textField;

+ (instancetype)alertControllerStyle1WithTitle:(NSString *)title message:(NSString *)message inputTextHandler:(void (^)(NSString *inputText))inputTextHandler;

@end
