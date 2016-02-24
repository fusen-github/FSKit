//
//  NSString+Extension.m
//  BaseLib
//
//  Created by Kevin Chou on 16/1/18.
//  Copyright (c) 2016年 navinfo. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
- (NSString *)trim
{
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString;
}
@end
