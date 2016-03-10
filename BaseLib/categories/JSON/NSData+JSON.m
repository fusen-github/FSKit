//
//  NSData+JSON.m
//  BaseLib
//
//  Created by Kevin Chou on 15-1-28.
//  Copyright (c) 2015年 nowsilence. All rights reserved.
//

#import "NSData+JSON.h"

@implementation NSData (JSON)

- (id)objectFromJSONData
{
    __autoreleasing NSError* error = nil;
    
    id result = [NSJSONSerialization JSONObjectWithData:self options:kNilOptions error:&error];
    
    if (error != nil) return nil;
    
    return result;
}
@end
