//
//  NSString+HSDocument.m
//  HSExtensions
//
//  Created by viewat on 16/4/19.
//  Copyright © 2016年 acerpeanut. All rights reserved.
//

#import "NSString+HSDocument.h"

@implementation NSString (HSDocument)
/**
 *  添加了Document目录后的路径
 *
 *  @return 添加了Document目录后的路径
 */
- (NSString *)hs_documentPath {
    NSString *dirPath = [NSString hs_documentDirectory];
    NSString *fileName = self;
    NSString *fullPath = [dirPath stringByAppendingPathComponent:fileName];
    
    return fullPath;
}

/**
 *  父目录
 *
 *  @return 父目录
 */
- (NSString *)hs_parentDirectory {
    return [self stringByDeletingLastPathComponent];
}

/**
 *  如果不存在这个目录，创建目录
 *
 *  @return 目录路径
 */
- (NSString *)hs_createDirectoryIfNotExist {
    [[NSFileManager defaultManager] createDirectoryAtPath:self withIntermediateDirectories:YES attributes:nil error:nil];
    return self;
}

/**
 *  Document目录的路径
 *
 *  @return Document目录的路径
 */
+ (NSString *)hs_documentDirectory {
    static NSString *docPath = nil;
    if (docPath == nil) {
        docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) firstObject];
    }
    return docPath;
}
@end
