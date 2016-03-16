//
//  NSString+DES.h
//  jiedanbao
//
//  Created by sdb on 15/6/26.
//  Copyright (c) 2015年 sdb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DES)

- (NSString *)desEncryptWithKey:(NSString *)key;//加密

- (NSString *)desDecryptWithKey:(NSString *)key;//解密

@end
