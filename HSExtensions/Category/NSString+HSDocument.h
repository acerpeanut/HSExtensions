//
//  NSString+HSDocument.h
//  HSExtensions
//
//  Created by viewat on 16/4/19.
//  Copyright © 2016年 acerpeanut. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HSDocument)

/**
 *  添加了Document目录后的路径
 *
 *  @return 添加了Document目录后的路径
 */
@property (nonatomic, readonly) NSString *hs_documentPath;

/**
 *  父目录
 *
 *  @return 父目录
 */
- (NSString *)hs_parentDirectory;

/**
 *  如果不存在这个目录，创建目录
 *
 *  @return 目录路径
 */
- (NSString *)hs_createDirectoryIfNotExist;

/**
 *  Document目录的路径
 *
 *  @return Document目录的路径
 */
+ (NSString *)hs_documentDirectory;


@end
