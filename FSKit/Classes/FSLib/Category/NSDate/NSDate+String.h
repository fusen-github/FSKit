//
//  NSDate+String.h
//  茗玥古城
//
//  Created by 似水灵修 on 13-11-12.
//  Copyright (c) 2013年 MingYueGuCheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDate (String)
/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;
/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;
/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;


/* 调试代码运行时长 */

/**
 *  调试代码 返回运行时长
 **/
+ (CGFloat)codeTimeBlock:(void (^)())myBlock;
/*     完     */
@end
