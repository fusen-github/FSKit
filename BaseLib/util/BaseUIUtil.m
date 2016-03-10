//
//  KCUIUtil.m
//  BaseLib
//
//  Created by Kevin Chou on 14-6-21.
//  Copyright (c) 2014年 nowsilence. All rights reserved.
//

#import "BaseUIUtil.h"

@implementation BaseUIUtil

+ (UIButton *)buttonWithTitle:(NSString *)title image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    
    if (image)
    {
        [btn setBackgroundImage:image forState:UIControlStateNormal];
    }
    
    if (highlightedImage)
    {
        [btn setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    }
    
    return btn;
}
@end
