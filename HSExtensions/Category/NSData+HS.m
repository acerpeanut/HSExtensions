//
//  NSData+HS.m
//  UnionpayDemo
//
//  Created by 刘欲扬 on 16/3/29.
//  Copyright © 2016年 viewat. All rights reserved.
//

#import "NSData+HS.h"

inline unsigned char asciiToHex(unsigned char b) {
    return  (b & 0x40)? (b & 0x0f) + 9 : (b & 0x0f);
}

inline unsigned char hexToAscii(unsigned char b) {
    return  b > 9 ? ((b-10)+'A') : (b + '0');
}


@implementation NSData (HS)

- (unsigned char)byteAtIndex:(int)index
{
    NSCAssert(index < self.length, @"长度越界");
    unsigned char *bytes = (unsigned char *)self.bytes;
    return bytes[index];
}

- (NSData *)dataByRemovePreLen:(int)removePreLen {
    if (removePreLen < 0 || removePreLen > self.length) {
        NSLog(@"移除的长度出错啦");
        return self;
    } else {
        unsigned char *bytes = (unsigned char *)self.bytes;
        return [NSData dataWithBytes:bytes+removePreLen length:self.length-removePreLen];
    }
}

- (NSData *)hs_bcdData {
    NSCAssert(self.length < 1000, @"要组bcd的数据长度超过1000");
    
    unsigned char BCDBuf[1000];
    unsigned char tmp1[1000];
    unsigned char *inputBytes = (unsigned char *)self.bytes;
    
    memset(tmp1, 0, 1000);
    memcpy(tmp1, inputBytes, self.length);

    // 转变为bcd码
    int bcdLen = 0;
    for (int i=0; i<self.length; i+=2) {
        BCDBuf[i/2] = (asciiToHex(tmp1[i]) << 4) + asciiToHex(tmp1[i+1]);
        bcdLen++;
    }
    return [NSData dataWithBytes:BCDBuf length:bcdLen];
}

- (NSData *)hs_unbcdData {
    NSCAssert(self.length*2 < 1000, @"要解bcd得数据长度超过1000");
    unsigned char unBCDBuf[1000];
    unsigned char *inputBytes = (unsigned char *)self.bytes;
    int i=0;
    for (i=0; i < self.length; i++) {
        unBCDBuf[i*2] = hexToAscii((inputBytes[i] & 0xF0)>>4);
        unBCDBuf[i*2+1] = hexToAscii(inputBytes[i] & 0x0F);
    }
    return [NSData dataWithBytes:unBCDBuf length:self.length*2];
}

- (NSString *)hs_utf8String {
    if (self.length) {
        return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    }
    return nil;
}
- (int)hs_strlen {
    int len = 0;
    if (self.length) {
        char *bytes = (char *)self.bytes;
        len = (int)strlen(bytes);
        if (len > self.length) {
            len = (int)self.length;
        }
    }
    return len;
}

- (NSString *)hs_hexString {
    NSMutableString *hexString = [NSMutableString string];
    unsigned char *bytes = (unsigned char *)self.bytes;
    for (int i=0; i<self.length; i++) {
        unsigned char high = hexToAscii(bytes[i] / 16);
        unsigned char low = hexToAscii(bytes[i] % 16);
        [hexString appendFormat:@"\\x%c%c", high, low];
    }
    return hexString;
}
- (NSString *)hs_hexStringPure {
    NSMutableString *hexString = [NSMutableString string];
    unsigned char *bytes = (unsigned char *)self.bytes;
    for (int i=0; i<self.length; i++) {
        unsigned char high = hexToAscii(bytes[i] / 16);
        unsigned char low = hexToAscii(bytes[i] % 16);
        [hexString appendFormat:@"%c%c", high, low];
    }
    return hexString;
}

/*
 * 把bytes转化为Data
 * e.g.:
 *      NSData *data = NSData.hs_unBytes("82973929729293", 14);
 */
+ (NSData * (^)(unsigned char *, int))hs_unBytes {
    return ^(unsigned char *bytes, int len) {
        return [NSData dataWithBytes:bytes length:len];
    };
}

/*
 * 转换int为两个字节的数据（高位在前，低位在后）
 * e.g.:
 *      NSData *lenData = NSData.hs_short2Byte(120);
 */
+ (NSData *(^)(int))hs_short2Byte {
    return ^(int len){
        unsigned char buf[2] = {0};
        buf[1] = (unsigned  char) (len & 0xff);
        buf[0] = (unsigned  char) ((len & (0xff << 8)) >> 8);
        return [NSData dataWithBytes:buf length:2];
    };
}

/*
 * 取出data的一段
 * e.g.:
 *      NSData *subData = data.hs_subData(0, 8); // 前8位
 */
- (NSData *(^)(int, int))hs_subData {
    return ^(int start, int len){
        NSCAssert(self.length >= start+len && start>=0, @"预设的数据缓存不足以支撑长数据");
        return [NSData dataWithBytes:self.bytes+start length:len];
    };
}

/*
 * 替换data中的一个字节（如果超出范围，创建更大的数据）
 * e.g.:
 *      NSData *lenData = data.hs_replaceChar(10, 'a');
 */
- (NSData *(^)(int, unsigned char))hs_replaceChar {
    return ^(int index, unsigned char replaceChar){
        unsigned char buf[1000];
        memset(buf, 0, 1000);
        
        NSCAssert(self.length < 1000 && index < 1000, @"预设的数据缓存不足以支撑长数据");
        memcpy(buf, self.bytes, self.length);
        buf[index] = replaceChar;
        
        // 替换后的数据长度
        long len = 0;
        if (index >= self.length) {
            len = index+1;
        } else {
            len = self.length;
        }
        
        return [NSData dataWithBytes:buf length:len];
    };
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@>", self.hs_hexStringPure];
}


@end
