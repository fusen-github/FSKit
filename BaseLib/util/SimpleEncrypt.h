//
//  SimpleEncrypt.h
//  BaseLib
//
//  Created by Kevin Chou on 15-1-27.
//  Copyright (c) 2015年 nowsilence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimpleEncrypt : NSObject

+ (NSData *)encypty:(NSData *)content key:(NSString *)key;

+ (NSData *)decrypt:(NSData *)data key:(NSString *)key;
@end
