//
//  NSString+Extension.h
//  BaseLib
//
//  Created by Kevin Chou on 16/1/18.
//  Copyright (c) 2016年 navinfo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (NSString *)trim;

/*
    @use: 将时间戳转化成固定格式的时间字符串
    @para: 传进来一个时间格式 eg:@"yyyy-MM-dd HH:mm:ss"
    @self: 时间戳
 */
- (NSString *)timeStampToFormateTimeWithDataFormatStr:(NSString *)formatStr;

@end
