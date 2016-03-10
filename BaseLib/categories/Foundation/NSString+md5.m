//
//  NSString+md5.m
//  BaseLib
//
//  Created by Kevin Chou on 14-8-21.
//  Copyright (c) 2014年 nowsilence. All rights reserved.
//

#import "NSString+md5.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (md5)

- (NSString *)md5
{
    const char* cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    static const char HexEncodeChars[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
    char *resultData = malloc(CC_MD5_DIGEST_LENGTH * 2 + 1);
    
    for (uint index = 0; index < CC_MD5_DIGEST_LENGTH; index++) {
        resultData[index * 2] = HexEncodeChars[(result[index] >> 4)];
        resultData[index * 2 + 1] = HexEncodeChars[(result[index] % 0x10)];
    }
    resultData[CC_MD5_DIGEST_LENGTH * 2] = 0;
    
    NSString *resultString = [NSString stringWithCString:resultData encoding:NSASCIIStringEncoding];
    free(resultData);
    
    return resultString;
}
@end
