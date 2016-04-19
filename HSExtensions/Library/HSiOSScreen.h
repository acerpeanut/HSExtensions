//
//  HSiOSScreen.h
//  3356SingleTestDemo
//
//  Created by 刘欲扬 on 16/3/10.
//  Copyright © 2016年 LGC. All rights reserved.
//

#ifndef HSiOSScreen_h
#define HSiOSScreen_h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - -iPhone 常量尺寸
/** 小屏幕的宽度：320 */
extern const CGFloat kSmallScreenWidth;
/** 小屏幕的高度：480 */
extern const CGFloat kSmallScreenHeight;
extern const CGFloat k_iPhone5_ScreenHeight;
extern const CGFloat k_iPhone6_ScreenWidth;
extern const CGFloat k_iPhone6_ScreenHeight;
extern const CGFloat k_iPhone6Plus_ScreenWidth;
extern const CGFloat k_iPhone6Plus_ScreenHeight;
/** 导航栏高度：44 */
extern const CGFloat kNavigationBarHeight;
/** 顶部bar（状态栏+导航栏）高度：64 */
extern const CGFloat kiPhoneTopBarHeight;
/** tabBar高度：49 */
extern const CGFloat kTabBarHeight;
/** 测试得出 UITableViewCell textLabel或imageView左侧默认的缩进 */
extern CGFloat zj_UITableViewCellLeftIndent();
/** 测试得出 UITableViewCell 当默认的imageView和textLabel都有值(有非空的显示内容)时, 两者之间的间距 */
extern CGFloat zj_UITableViewCellInteritemPaddingBetweenImageViewAndTextLabel();
/** 测试得出 UITableViewCell accessoryView右侧默认的缩进 */
extern CGFloat zj_UITableViewCellAccessoryViewRightIndent();

#pragma mark - 屏幕宽高
/** 屏幕宽高 */
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
/** 宽度放大比例 */
#define kScreenWidthScaleRatio (kScreenWidth / k_iPhone6_ScreenWidth)
/** 高度放大比例 */
#define kScreenHeightScaleRatio (kScreenHeight / k_iPhone6_ScreenHeight)

extern inline CGFloat zj_separatorWidth(); 

#pragma mark - 系统、机型判断
/** 判断系统版本是否大于7.0 */
#define IsiOS7OrLater ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
#define IsiOS8OrLater ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
/** 判断机型 */
#define Is480Height (kScreenHeight == kSmallScreenHeight)
#define Is568Height (kScreenHeight == k_iPhone5_ScreenHeight)
#define Is667Height (kScreenHeight == k_iPhone6_ScreenHeight)
#define Is736Height (kScreenHeight == k_iPhone6Plus_ScreenHeight)


#endif /* HSiOSScreen_h */
