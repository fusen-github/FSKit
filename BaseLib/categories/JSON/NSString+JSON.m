//
//  NSString+JSON.m
//  BaseLib
//
//  Created by Kevin Chou on 15-1-28.
//  Copyright (c) 2015年 nowsilence. All rights reserved.
//

#import "NSString+JSON.h"

@implementation NSString (JSON)

- (id)objectFromJSONString
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    __autoreleasing NSError* error = nil;
    
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (error != nil) return nil;
    
    return result;
}

@end
