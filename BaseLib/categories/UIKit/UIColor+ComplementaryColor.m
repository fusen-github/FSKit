//
//  UIColor+ComplementaryColor.m
//  BaseLib
//
//  Created by Kevin Chou on 14-8-29.
//  Copyright (c) 2014年 nowsilence. All rights reserved.
//

#import "UIColor+ComplementaryColor.h"

@implementation UIColor (ComplementaryColor)
+ (UIColor *)oppositeColorOf:(UIColor *)mainColor
{
    /*
     
     + (UIColor *)blackColor;      // 0.0 white
     + (UIColor *)darkGrayColor;   // 0.333 white
     + (UIColor *)lightGrayColor;  // 0.667 white
     + (UIColor *)whiteColor;      // 1.0 white
     + (UIColor *)grayColor;       // 0.5 white
     
     */
    
    if ([mainColor isEqual:[UIColor blackColor]]) {
        mainColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    }
    else if ([mainColor isEqual:[UIColor darkGrayColor]]) {
        mainColor = [UIColor colorWithRed:84.915/255.f green:84.915/255.f blue:84.915/255.f alpha:1];
    }
    else if ([mainColor isEqual:[UIColor lightGrayColor]]) {
        mainColor = [UIColor colorWithRed:170.085/255.f green:170.085/255.f blue:170.085/255.f alpha:1];
    }
    else if ([mainColor isEqual:[UIColor whiteColor]]) {
        mainColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    }
    else if ([mainColor isEqual:[UIColor grayColor]]) {
        mainColor = [UIColor colorWithRed:127.5/255.f green:127.5/255.f blue:127.5/255.f alpha:1];
    }
    
    const CGFloat *componentColors = CGColorGetComponents(mainColor.CGColor);
    
    UIColor *convertedColor = [[UIColor alloc] initWithRed:(1.0 - componentColors[0])
                                                     green:(1.0 - componentColors[1])
                                                      blue:(1.0 - componentColors[2])
                                                     alpha:componentColors[3]];
    return convertedColor;
}
@end
