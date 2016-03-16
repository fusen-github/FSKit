//
//  NSString+Hash.h
//  茗玥古城
//
//  Created by 似水灵修 on 13-11-11.
//  Copyright (c) 2013年 MingYueGuCheng. All rights reserved.
//
/**
 命令行测试命令
 加密abc字符串:
 MD5:
 $ echo -n abc | openssl md5
 SHA1:
 $ echo -n abc | openssl sha1
 SHA256:
 $ echo -n abc | openssl sha -sha256
 SHA512:
 $ echo -n abc | openssl sha -sha512
 
 */

#import <Foundation/Foundation.h>

@interface NSString (Hash)

@property (nonatomic, readonly) NSString *md5String;
@property (nonatomic, readonly) NSString *sha1String;
@property (nonatomic, readonly) NSString *sha256String;
@property (nonatomic, readonly) NSString *sha512String;

@end
