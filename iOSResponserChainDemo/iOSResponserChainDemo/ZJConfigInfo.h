//
//  ZJConfigInfo.h
//  iOSResponserChainDemo
//
//  Created by ZhouJian09 on 2021/9/30Thursday.
//  Copyright © 2021 chooingSl Inc. All rights reserved.
//

#ifndef ZJConfigInfo_h
#define ZJConfigInfo_h

//navigation 高度
#define kNavigationBarBottom  (kZJStatusBarHeight + kZJNavigationBarHeight)

//状态栏高度
#define kZJStatusBarHeight                  (kZJDeviceIsFullScreen ? 44 : 20)

//NavigationBar 高度
#define kZJNavigationBarHeight              44

//判断是否为全面屏
#define kZJDeviceIsFullScreen (kZJDeviceIsIphoneX == YES || kZJDeviceIsIphoneXR == YES || kZJDeviceIsIphoneXS == YES || kZJDeviceIsIphoneXS_MAX == YES || kIsZJScreen)

//判断iPhoneX
#define kZJDeviceIsIphoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !kZJDeviceIsPad : NO)

//判断iPHoneXr
#define kZJDeviceIsIphoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(750, 1624), [[UIScreen mainScreen] currentMode].size)) && !kZJDeviceIsPad : NO)

//判断iPhoneXs
#define kZJDeviceIsIphoneXS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !kZJDeviceIsPad : NO)
//判断iPhoneXs Max
#define kZJDeviceIsIphoneXS_MAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !kZJDeviceIsPad : NO)

//判断iPad
#define kZJDeviceIsPad       (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define kZJDeviceIsPhone     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)


#define IS_IOS_11  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.f)

// 判断是否刘海屏
#define kIsZJScreen (IS_IOS_11 && kZJDeviceIsPhone && (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) >= 375 && MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) >= 812))

#define kScreenHeight                       [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth                        [[UIScreen mainScreen] bounds].size.width

//底部的安全距离
#define kBottomSafeAreaHeight [UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom


#endif /* ZJConfigInfo_h */
