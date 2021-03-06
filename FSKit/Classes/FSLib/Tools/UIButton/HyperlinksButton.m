//
//  HyperlinksButton.m
//  shuaidanbao
//
//  Created by 吴浪 on 15/10/20.
//  Copyright © 2015年 sdb. All rights reserved.
//

#import "HyperlinksButton.h"

@implementation HyperlinksButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _lineColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGRect textRect = self.titleLabel.frame;
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    CGFloat descender = self.titleLabel.font.descender;
    
    if([_lineColor isKindOfClass:[UIColor class]])
    {
        CGContextSetStrokeColorWithColor(contextRef, _lineColor.CGColor);
    }
    
    CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + textRect.size.height + descender + 3.0);
    
    CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height + descender + 3.0);
    
    CGContextClosePath(contextRef);
    
    CGContextDrawPath(contextRef, kCGPathStroke);
}

@end
