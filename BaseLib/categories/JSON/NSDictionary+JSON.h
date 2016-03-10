//
//  NSDictionary+JSON.h
//  BaseLib
//
//  Created by Kevin Chou on 15-1-28.
//  Copyright (c) 2015年 nowsilence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSON)

- (NSString *)JSONString;

- (NSData *)JSONData;

- (id)safeObjectForKey:(id)key;

- (NSString *)stringForKey:(id)key;
@end
