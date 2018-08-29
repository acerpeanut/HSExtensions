//
//  HSValidateTool.h
//  WarmCar
//
//  Created by admin  on 2017/12/28.
//  Copyright © 2017年 GangQinPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HSValidateTool : NSObject

// 限制输入的最大长度
+ (void)RestrictTextField:(UITextField *)textField ToMaxLength:(NSInteger)maxLength;

// 去除emoji字符
+ (void)textFieldDisableEmoji:(UITextField *)textField;

+ (void)textViewDisableEmoji:(UITextView *)textView;

//身份证号（大陆/港澳台）
+ (BOOL)CheckIsValidIdentityCard:(NSString *)identityCard;


/**
 检查手机号码是否合法

 @param phoneNum 手机号码
 @return 是否合法
 */
+ (BOOL)isPhoneLegal:(NSString *)phoneNum;


@end
