//
//  NSString+Base64.h
//  茗玥古城
//
//  Created by 似水灵修 on 13-11-11.
//  Copyright (c) 2013年 MingYueGuCheng. All rights reserved.
//
#import <Foundation/Foundation.h>
/**
 *  终端测试指令
 *
 *  BASE64编码(abc)
 *  $ echo -n abc | base64
 *
 *  BASE64解码(YWJj，abc的编码)
 *  $ echo -n YWJj | base64 -D
 */
@interface NSString(Base64)

/**
 *  返回Base64编码后的字符串
 */
@property (nonatomic, readonly) NSString *base64Encode;

/**
 *  返回Base64解码后的字符串
 */
@property (nonatomic, readonly) NSString *base64Decode;

@end
