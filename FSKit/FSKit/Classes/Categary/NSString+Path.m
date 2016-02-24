//
//  NSString+Path.m
//  测试分类
//
//  Created by 四维图新 on 15/11/26.
//  Copyright (c) 2015年 四维图新. All rights reserved.
//

#import "NSString+Path.h"

@implementation NSString (Path)

// AppendingPathComponent


- (NSString *)appendingDocumentPath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    path = [path stringByAppendingPathComponent:self];
    
    return path;
}


- (NSString *)appendingCachePath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    path = [path stringByAppendingPathComponent:self];
    
    return path;
}

- (NSString *)appendingTmpPath
{
    NSString *path = NSTemporaryDirectory();
    
    path = [path stringByAppendingPathComponent:self];
    
    return path;
}



@end
