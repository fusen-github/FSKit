//
//  KCUtil.h
//  BaseLib
//
//  Created by Kevin Chou on 14/6/24.
//  Copyright (c) 2014年 nowsilence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseUtil : NSObject
+ (int)getAttributedStringHeight:(NSAttributedString *)string width:(int)width;
+ (NSInteger)getYearOfDate:(NSDate *)date;
+ (NSString *)formatDate:(NSDate *)date format:(NSString *)format;
+ (NSString *)getMacAddress;
+ (NSString*)_UDID_iOS7;

+ (int)hexToDecimal:(int)hexInt;


/*!
 *  @brief 将浮点数转换为字符串，右边去0，etc. 7.50 输出7.5
 *  @param value 浮点型数值
 */
+ (NSString *)convertFloatToString:(float)value;
@end
