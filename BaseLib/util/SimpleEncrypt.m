//
//  SimpleEncrypt.m
//  BaseLib
//
//  Created by Kevin Chou on 15-1-27.
//  Copyright (c) 2015年 nowsilence. All rights reserved.
//

#import "SimpleEncrypt.h"

@implementation SimpleEncrypt

+ (NSData *)encypty:(NSData *)data key:(NSString *)key
{
    NSData *_data = [NSData dataWithBytes:[data bytes] length:data.length];
    
    const void * b=[_data bytes];
    
    const void * keyBytes = [[key dataUsingEncoding:NSUTF8StringEncoding] bytes];
    
    [[self class] encryptByte:(Byte *)b
             keyBytes:(Byte *)keyBytes
                start:0
        contentLength:_data.length
            keyLength:[key dataUsingEncoding:NSUTF8StringEncoding].length];
    
    return [NSData dataWithBytes:b length:_data.length];
}

+ (void)encryptByte:(Byte *)bytes
           keyBytes:(Byte *)keyBytes
              start:(NSInteger)start
      contentLength:(NSInteger)contentLength
          keyLength:(NSInteger)keyLength
{
    if (start == contentLength) {
        return;
    }
    
    NSInteger end = start + keyLength;
    
    if (end >= contentLength) {
        end = contentLength;
    }
    
    for (NSInteger i =start; i < end; i++) {
        bytes[i] ^= keyBytes[i - start];
    }
    
    [[self class] encryptByte:bytes keyBytes:keyBytes start:end contentLength:contentLength keyLength:keyLength];
}

+ (NSData *)decrypt:(NSData *)data key:(NSString *)key
{
    return [[self class] encypty:data key:key];
}

@end
