//
//  HSiOSScreen.m
//  3356SingleTestDemo
//
//  Created by 刘欲扬 on 16/3/10.
//  Copyright © 2016年 LGC. All rights reserved.
//
#import "HSiOSScreen.h"



const CGFloat kSmallScreenWidth          = 320.0f;
const CGFloat kSmallScreenHeight         = 480.0f;
const CGFloat k_iPhone5_ScreenHeight     = 568.0f;
const CGFloat k_iPhone6_ScreenWidth      = 375.f;
const CGFloat k_iPhone6_ScreenHeight     = 667.0f;
const CGFloat k_iPhone6Plus_ScreenWidth  = 414.0f;
const CGFloat k_iPhone6Plus_ScreenHeight = 736.0f;
const CGFloat kNavigationBarHeight       = 44.0f;
const CGFloat kiPhoneTopBarHeight        = 64.0f;
const CGFloat kTabBarHeight              = 49.0f;
inline CGFloat zj_UITableViewCellLeftIndent()
{
    
    if (kScreenHeight >= k_iPhone6Plus_ScreenHeight) {
        return 20.f;
    } else {
        return 15.f;
    }
}

inline CGFloat zj_separatorWidth() {
    return 1.2f / [UIScreen mainScreen].scale;
}

inline CGFloat zj_UITableViewCellInteritemPaddingBetweenImageViewAndTextLabel()
{
    if (kScreenHeight >= k_iPhone6Plus_ScreenHeight) {
        return 20.f;
    } else {
        return 15.f;
    }
}
inline CGFloat zj_UITableViewCellAccessoryViewRightIndent()
{
    if (kScreenHeight >= k_iPhone6Plus_ScreenHeight) {
        return 20.f;
    } else {
        return 15.f;
    }
}
