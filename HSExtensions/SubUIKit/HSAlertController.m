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
@property (nonatomic, strong) UITextField *textField;
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

    [alertController setupActions];
    alertController.inputTextHandler = inputTextHandler;
    return alertController;
}

+ (instancetype)alertControllerStyleDefaultWithTitle:(NSString *)title message:(NSString *)message {
    HSAlertController *alertController = [HSAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController setupActions];
    return alertController;
}

- (void)setupActions {
    @weakify(self);
    [self addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        if (self.onCancel) {
            self.onCancel();
        }
    }]];
    [self addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        if (self.onConfirm) {
            self.onConfirm();
        }
    }]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.textField resignFirstResponder];
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
