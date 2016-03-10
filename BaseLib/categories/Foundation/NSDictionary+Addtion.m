//
//  NSDictionary+Addtion.m
//  BaseLib
//
//  Created by Kevin Chou on 14-8-29.
//  Copyright (c) 2014年 nowsilence. All rights reserved.
//

#import "NSDictionary+Addtion.h"

@implementation NSDictionary (Addtion)
- (id)safeObjectForKey:(id)theKey {
    id theObject = [self objectForKey:theKey];
    return ([theObject isEqual:[NSNull null]]) ? nil : theObject;
}

- (id)notNilStringForKey:(id)theKey {
    id theObject = [self objectForKey:theKey];
    if (theObject == nil || [theObject isEqual:[NSNull null]]) return @"";
    return theObject;
}
@end
