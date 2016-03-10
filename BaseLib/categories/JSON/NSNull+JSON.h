//
//  NSNull+Json.h
//  BaseLib
//
//  Created by Kevin Chou on 15-1-28.
//  Copyright (c) 2015年 nowsilence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNull (JSON)

- (NSUInteger)length;

- (NSInteger)integerValue;

- (int) intValue;

- (double) doubleValue;

- (NSUInteger) unsignedIntegerValue;

- (float)floatValue;

- (NSString *)description;

- (NSArray *)componentsSeparatedByString:(NSString *)separator;

- (id)objectForKey:(id)key;

- (BOOL)boolValue;

- (NSString *)stringValue;

@end
