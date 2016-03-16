//
//  UIColor+Utils.h
//  WNCompany
//
//  Created by gaoxin on 14/12/17.
//  Copyright (c) 2014年 SimGao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Utils)
/**
 将16进制颜色值如#000000转换成UIColor
 **/
+ (UIColor*)colorWithHexString:(NSString *)stringToConvert;

+ (UIColor*)colorWithHexString:(NSString *)stringToConvert alpha:(float)_alpha;

@end
