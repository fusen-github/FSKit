//
//  NSData+AES.h
//  jiedanbao
//
//  Created by sdb on 15/6/26.
//  Copyright (c) 2015年 sdb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES)

/** 加密 */
- (NSData *)aes256EncryptWithKey:(NSString *)key;

/** 解密 */
- (NSData *)aes256DecryptWithKey:(NSString *)key;

@end
