//
//  WCImagePicker.m
//  WarmCar
//
//  Created by admin  on 2018/1/12.
//  Copyright © 2018年 GangQinPeng. All rights reserved.
//

#import "WCImagePicker.h"

@interface WCImagePicker () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, weak) UIViewController *currentVC;
@property (nonatomic, copy) void (^finishBlock)(UIImage * _Nonnull image);
@end

@implementation WCImagePicker

- (instancetype)init {
    return [self initWithTitle:@""];
}

- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super init]) {
        self.title = title;
        self.allowVideo = NO;
        self.allowLibrary = YES;
    }
    return self;
}

- (void)showPhotoActionSheetInVC:(UIViewController *)vc finish:(void (^)(UIImage * _Nonnull))finsh {
    self.finishBlock = finsh;
    self.currentVC = vc;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:self.title message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectActionWithButtonIndex:0 delegate:self];
    }];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectActionWithButtonIndex:1 delegate:self];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:cameraAction];
    if (self.allowLibrary) {
        [alertController addAction:photoAction];
    }
    
    [vc presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Private

- (void)selectActionWithButtonIndex:(NSInteger)buttonIndex delegate:(id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)delegate {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    
    [picker setDelegate:delegate];
//    picker.navigationBar.backgroundColor=kColorYellow2;
    picker.modalTransitionStyle = 0;
    
    if (! self.allowVideo) {
        picker.allowsEditing = NO;
    } else {
        picker.allowsEditing = YES;
        picker.videoMaximumDuration = 30.0f; // 30 seconds
        picker.mediaTypes = [NSArray arrayWithObjects:@"public.movie", @"public.image", nil];
    }
    
    if (buttonIndex == 0) { // 拍照
#if TARGET_OS_SIMULATOR
        return;
#else
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
#endif
    } else if (buttonIndex == 1) { // 相册
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else if (buttonIndex == 2) { // 取消
        return;
    }
    [self.currentVC presentViewController:picker animated:YES completion:^{}];
}

//根据图片名将图片保存到ImageFile文件夹中
+ (BOOL)saveToDocument:(UIImage *)image name:(NSString *)fileName {
    NSString *imagePath = [WCImagePicker imageSavedPath:fileName];
    return [WCImagePicker saveToDocument:image withFilePath:imagePath];
}

//根据图片名将图片保存到ImageFile文件夹中
+ (NSString *)imageSavedPath:(NSString *)imageName {
    //获取Documents文件夹目录
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [path objectAtIndex:0];
    
    //获取文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //指定新建文件夹路径
    NSString *imageDocPath = [documentPath stringByAppendingPathComponent:@"ImageFile"];
    
    //创建ImageFile文件夹
    [fileManager createDirectoryAtPath:imageDocPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    //返回保存图片的路径（图片保存在ImageFile文件夹下）
    NSString * imagePath = [imageDocPath stringByAppendingPathComponent:imageName];
    
    return imagePath;
}

//将选取的图片保存到目录文件夹下
+ (BOOL)saveToDocument:(UIImage *) image withFilePath:(NSString *) filePath {
    if ((image == nil) || (filePath == nil) || [filePath isEqualToString:@""]) {
        return NO;
    }
    @try {
        
        NSData *imageData = nil;
        
        //获取文件扩展名
        NSString *extention = [filePath pathExtension];
        
        if ([extention isEqualToString:@"png"]) {
            //返回PNG格式的图片数据
            imageData = UIImagePNGRepresentation(image);
        } else {
            //返回JPG格式的图片数据，第二个参数为压缩质量：0:best 1:lost
            imageData = UIImageJPEGRepresentation(image, 0.4);
        }
        if (imageData == nil || [imageData length] <= 0) {
            return NO;
        }
        //将图片写入指定路径
        [imageData writeToFile:filePath atomically:YES];
        
        return  YES;
    } @catch (NSException *exception) {
        NSLog(@"保存图片失败");
    }
    return NO;
}

#pragma mark - 上传图片相关
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (image == nil) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    if (self.finishBlock && image) {
        self.finishBlock(image);
    }
    [picker dismissViewControllerAnimated:YES completion:^{

    }];
}

@end
