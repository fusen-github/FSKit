//
//  UIColor+Extension.m
//  FSKit
//
//  Created by 四维图新 on 16/3/10.
//  Copyright © 2016年 四维图新. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+ (UIColor *)colorWithHexString:(NSString *)hex
{
    hex= [[hex uppercaseString] substringFromIndex:1];
    
    CGFloat valueArray[3];
    
    NSArray *strArray = [NSArray arrayWithObjects:[hex substringWithRange:NSMakeRange(0, 2)],[hex substringWithRange:NSMakeRange(2, 2)],[hex substringWithRange:NSMakeRange(4, 2)] ,nil];
    
    for( int i=0;i<strArray.count;i++)
    {
        hex=strArray[i];
        
        CGFloat value=([hex characterAtIndex:0]>'9'?[hex characterAtIndex:0]-'A'+10:[hex characterAtIndex:0]-'0')*16.0f+([hex characterAtIndex:1]>'9'?[hex characterAtIndex:1]-'A'+10:[hex characterAtIndex:1]-'0');
        
        valueArray[i]=value;
    }
    
    return [UIColor colorWithRed:valueArray[0]/255 green:valueArray[1]/255 blue:valueArray[2]/255 alpha:1];
}





@end
