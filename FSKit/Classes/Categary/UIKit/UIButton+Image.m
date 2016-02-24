//
//  UIButton+Image.m
//  BaseLib
//
//  Created by Kevin Chou on 15/6/30.
//  Copyright (c) 2015年 nowsilence. All rights reserved.
//

#import "UIButton+Image.h"

@implementation UIButton (Image)

+ (UIButton *)buttonWithImage:(UIImage *)image
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (image)
    {
        btn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        
        [btn setImage:image forState:UIControlStateNormal];    
    }
    
    return btn;
}

+ (UIButton *)buttonWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    UIButton *btn = [[self class] buttonWithImage:image];
    
    [btn setImage:highlightedImage forState:UIControlStateHighlighted];
    
    return btn;
}

@end
