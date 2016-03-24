//
//  NIProgressBar.m
//  FastMap
//
//  Created by Kevin Chou on 15/10/23.
//  Copyright (c) 2015年 四维图新. All rights reserved.
//

#import "NIProgressBar.h"

@implementation NIProgressBar

- (void)setPercent:(float)percent
{
    _percent = percent;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGColorRef fillColor = [[UIColor lightGrayColor] CGColor];
    
    CGContextSetFillColorWithColor(ctx, fillColor);

    CGContextFillRect(ctx,self.bounds);
    
    CGContextSetFillColorWithColor(ctx, [[UIColor blueColor] CGColor]);
    
    CGRect frame = CGRectMake(0, 0, self.bounds.size.width * self.percent, self.bounds.size.height);
    
    CGContextFillRect(ctx, frame);
}
@end
