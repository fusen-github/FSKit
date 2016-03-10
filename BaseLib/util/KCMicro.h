//
//  KCMicro.h
//  BaseLib
//
//  Created by Kevin Chou on 14-6-21.
//  Copyright (c) 2014年 nowsilence. All rights reserved.
//

#ifndef BaseLib_KCMicro_h
#define BaseLib_KCMicro_h

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer］

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define SW ([UIScreen mainScreen].bounds.size.width)

#define SH ([UIScreen mainScreen].bounds.size.height)

#define TOP_HEIGHT ([[[UIDevice currentDevice] systemVersion] floatValue] < 7 ? 0 : 64)

#define kcp(x,y) CGPointMake(x,y)
#define kcr(x,y,w,h) CGRectMake(x,y,w,h)

#define UserDefaults [NSUserDefaults standardUserDefaults]

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define KCString(string) (string ? string : @"")

#endif
