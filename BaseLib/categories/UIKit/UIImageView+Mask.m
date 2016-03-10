//
//  UIImageView+Circle.m
//  BaseLib
//
//  Created by Kevin Chou on 14/6/30.
//  Copyright (c) 2014年 nowsilence. All rights reserved.
//

#import "UIImageView+Mask.h"

@implementation UIImageView (Mask)

- (void)maskWith:(UIImage *)image
{
    UIGraphicsBeginImageContext(self.bounds.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextFillRect(ctx, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height));
    
    UIGraphicsEndImageContext();
    
    CALayer* roundCornerLayer = [CALayer layer];
    
    roundCornerLayer.frame = self.bounds;
    
    roundCornerLayer.contents = (id)[image CGImage];
    
    [[self layer] setMask:roundCornerLayer];
}


@end
