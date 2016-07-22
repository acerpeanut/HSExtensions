//
//  HSAlertController.m
//  UnionpayDemo
//
//  Created by viewat on 16/7/5.
//  Copyright © 2016年 viewat. All rights reserved.
//

#import "HSAlertController.h"
#import "HSCommon.h"

@interface HSAlertController () <UITextFieldDelegate>
@property (nonatomic, copy) void (^inputTextHandler)(NSString *inputText);
@end

@implementation HSAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (instancetype)alertControllerStyle1WithTitle:(NSString *)title message:(NSString *)message inputTextHandler:(void (^)(NSString *inputText))inputTextHandler {
    HSAlertController *alertController = [HSAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    @weakify(alertController);
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        @strongify(alertController);
        textField.delegate = alertController;
        alertController.textField = textField;
    }];
    alertController.inputTextHandler = inputTextHandler;
    return alertController;
}

#pragma mark
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.inputTextHandler) {
        self.inputTextHandler(textField.text);
    }
    [self dismissViewControllerAnimated:YES completion:^{
        HSLog(@"alertController dismiss");
    }];
    
}

@end
