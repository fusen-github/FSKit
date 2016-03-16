//
//  MD5Utils.m
//  jxtuan
//
//  Created by 融通互动 on 13-10-17.
//  Copyright (c) 2013年 aaa. All rights reserved.
//

#import "MD5Utils.h"
#import "CommonCrypto/CommonDigest.h"

@implementation MD5Utils


+ (NSString *)md5:(NSString *)origin
{
    const char *cStr = [origin UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ];
}

+ (NSString *)stringFromMD5:(NSString *)md5String
{
    
    if(md5String == nil || [md5String length] == 0)
        return nil;
    const char *value = [md5String UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++)
    {
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    return outputString;
}



@end
