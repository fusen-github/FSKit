//
//  NSDictionary+JSON.m
//  BaseLib
//
//  Created by Kevin Chou on 15-1-28.
//  Copyright (c) 2015年 nowsilence. All rights reserved.
//

#import "NSDictionary+JSON.h"


@implementation NSDictionary (JSON)

- (NSString *)JSONString
{
    NSData *jsonData = [self JSONData];
    
    if (!jsonData)
    {
        return @"";
    }
    
    NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    return json;
}

- (NSData *)JSONData
{
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (error)
    {
        //DLog(@"%@\n解析出错：\n%@",self,error);
        return nil;
    }
    
    return jsonData;
}

- (NSString *)stringForKey:(id)key
{
    id object = [self objectForKey:key];
    
    if (object == [NSNull null])
        return @"";
    
    return object;
}

- (id)safeObjectForKey:(id)key
{
    id object = [self objectForKey:key];

    if (object == [NSNull null])
        return nil;
    
    return object;
}
@end
