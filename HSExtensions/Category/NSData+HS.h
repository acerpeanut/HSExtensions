//
//  NSData+HS.h
//  UnionpayDemo
//
//  Created by 刘欲扬 on 16/3/29.
//  Copyright © 2016年 viewat. All rights reserved.
//

#import <Foundation/Foundation.h>

extern unsigned char asciiToHex(unsigned char b);
extern unsigned char hexToAscii(unsigned char b);

@interface NSData (HS)

- (unsigned char)byteAtIndex:(int)index;
- (NSData *)dataByRemovePreLen:(int)removePreLen;

- (NSData *)hs_unbcdData;

/**
 * 对数据进行BCD转换
 */
- (NSData *)hs_bcdData;

- (NSString *)hs_utf8String;
- (int)hs_strlen;
- (NSString *)hs_hexString;
- (NSString *)hs_hexStringPure;

/**
 * 取出data的一段
 * e.g.:
 *      NSData *subData = data.hs_subData(0, 8); // 前8位
 */
- (NSData * (^)(int, int))hs_subData;

/**
 * 把bytes转化为Data
 * e.g.:
 *      NSData *data = NSData.hs_unBytes("82973929729293", 14);
 */
+ (NSData * (^)(unsigned char *, int))hs_unBytes;

/**
 * 转换int为两个字节的数据（高位在前，低位在后）
 * e.g.:
 *      NSData *lenData = NSData.hs_short2Byte(120);
 */
+ (NSData * (^)(int))hs_short2Byte;

/**
 * 替换data中的一个字节（如果超出范围，创建更大的数据）
 * e.g.:
 *      NSData *lenData = data.hs_replaceChar(10, 'a');
 */
- (NSData *(^)(int, unsigned char))hs_replaceChar;
@end

//@interface NSData (HSConvert)
//
//@end
