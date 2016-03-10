//
//  NSDictionary+Addtion.h
//  BaseLib
//
//  Created by Kevin Chou on 14-8-29.
//  Copyright (c) 2014年 nowsilence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Addtion)
- (id)safeObjectForKey:(id)theKey;
- (id)notNilStringForKey:(id)theKey;
@end
