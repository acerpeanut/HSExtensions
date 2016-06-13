//
//  HSCommon.m
//  HSExtensions
//
//  Created by viewat on 16/5/10.
//  Copyright © 2016年 acerpeanut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HSCommon.h"

/// 在主线程执行
void hs_runOnMainThread(void (^block)()) {
    if (block) {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}