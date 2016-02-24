//
//  NCLineButton.m
//  lineButton
//
//  Created by Nigel Chou on 15/12/20.
//  Copyright (c) 2015年 BeautyFuture. All rights reserved.
//

#import "NCLineButton.h"

@interface NCLineButton()
{
    NSMutableDictionary *_colors;
    
    NSMutableDictionary *_backgroundColors;
    
    NSMutableDictionary *_titles;
    
    UILabel *_titleLabel;
}
@end

@implementation NCLineButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        _colors = [NSMutableDictionary dictionaryWithCapacity:3];
        
        [_colors setObject:[UIColor colorWithRed:0 green:122/255.f blue:1 alpha:1] forKey:@(UIControlStateNormal)];
        
        _backgroundColors = [NSMutableDictionary dictionaryWithCapacity:3];
        
        _titles = [NSMutableDictionary dictionaryWithCapacity:3];
        
        self.cornerRadius = frame.size.height / 2;
        
        self.lineWidth = 1;
        
        _titleFont = [UIFont systemFontOfSize:14];
        
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        
        _titleLabel.textColor = [_colors objectForKey:@(UIControlStateNormal)];
        
        _titleLabel.font = _titleFont;
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_titleLabel];
        
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    
    return self;
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleLabel.font = titleFont;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIColor *strokeColor = [self colorForState:self.state];
    
    UIColor *fillColor = [self backgroundColorForState:self.state];
    
    CGContextSetFillColorWithColor(ctx, [fillColor CGColor]);
    
    CGContextSetStrokeColorWithColor(ctx, [strokeColor CGColor]);
    
    CGContextSaveGState(ctx);
    
    CGContextSetLineWidth(ctx, _lineWidth);
    
    CGRect rrect = CGRectInset(self.bounds, _lineWidth, _lineWidth);

    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rrect cornerRadius:self.cornerRadius];

    // draw background
    if(fillColor)
    {
        CGContextAddPath(ctx, path.CGPath);
        
        CGContextFillPath(ctx);
    }
    
    CGContextRestoreGState(ctx);
    
    if (self.state != UIControlStateSelected || self.state != UIControlStateHighlighted)
    {
        // draw line
        CGContextAddPath(ctx, path.CGPath);
        
        CGContextStrokePath(ctx);
    }
    
    _titleLabel.textColor = strokeColor;

    _titleLabel.text = [self titleForState:self.state];
}


- (NSString *)titleForState:(UIControlState)state
{
    NSString *text = [_titles objectForKey:@(state)];
    
    if (!text) {
        text = [_titles objectForKey:@(UIControlStateNormal)];
    }
    
    return text;
}

- (UIColor *)colorForState:(UIControlState)state
{
    UIColor *color = [_colors objectForKey:@(state)];
    
    if (!color)
    {
        color = [_colors objectForKey:@(UIControlStateNormal)];
        
        if (state == UIControlStateDisabled)
        {
            color = [color colorWithAlphaComponent:.6];
        }
        else if(state == UIControlStateHighlighted || state == UIControlStateSelected)
        {
            return [UIColor whiteColor];
        }
    }
    
    return color;
}

- (UIColor *)backgroundColorForState:(UIControlState)state
{
    UIColor *color = [_backgroundColors objectForKey:@(state)];
    
    if (!color)
    {
        color = [_backgroundColors objectForKey:@(UIControlStateNormal)];
        
        if (state == UIControlStateDisabled)
        {
            color = [color colorWithAlphaComponent:.6];
        }
        else if(state == UIControlStateHighlighted || state == UIControlStateSelected)
        {
            return [self colorForState:UIControlStateNormal];
        }
    }
    
    return color;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    [self setNeedsDisplay];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    [self setNeedsDisplay];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [_titles setObject:title forKey:@(state)];
}

- (void)setColor:(UIColor *)color forState:(UIControlState)state
{
    [_colors setObject:color forKey:@(state)];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    [_backgroundColors setObject:backgroundColor forKey:@(state)];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *touchView = [super hitTest:point withEvent:event];
    if ([self pointInside:point withEvent:event])
    {
        return self;
    }
    
    return touchView;
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    self.highlighted = YES;
        
    return [super beginTrackingWithTouch:touch withEvent:event];
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    return [super continueTrackingWithTouch:touch withEvent:event];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    self.highlighted = NO;
    
    [super endTrackingWithTouch:touch withEvent:event];
}

- (void)cancelTrackingWithEvent:(UIEvent *)event
{
    self.highlighted = NO;

    [super cancelTrackingWithEvent:event];
}

@end
