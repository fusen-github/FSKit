//
//  KCKeyChain.h
//  BaseLib
//
//  Created by Kevin Chou on 14-9-1.
//  Copyright (c) 2014年 nowsilence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCKeyChain : NSObject
+ (void)delete:(NSString *)service;
+ (id)load:(NSString *)service;
+ (void)save:(NSString *)service data:(id)data;
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;
@end
