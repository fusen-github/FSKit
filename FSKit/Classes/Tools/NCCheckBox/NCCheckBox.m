//
//  NCCheckBox.m
//  CheckBox
//
//  Created by Nigel Chou on 16/1/28.
//  Copyright (c) 2016年 BeautyFuture. All rights reserved.
//

#import "NCCheckBox.h"

@implementation NCCheckBox
{
    __weak UIButton *_button;
    
    BOOL _imageSetted;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = self.bounds;
        
        [self addSubview:button];
        
        _button = button;
        
        _button.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        self.tintColor = [UIColor colorWithRed:0 green:122/255.f blue:1 alpha:1];
        
        [button setTitleColor:[UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1]
                     forState:UIControlStateNormal];
        
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [self setupDefaultImage];
        
        int gap = 5;
        
        _button.titleEdgeInsets = UIEdgeInsetsMake(0, gap, 0, -gap);
        
        [_button addTarget:self
                    action:@selector(buttonClicked:)
          forControlEvents:UIControlEventTouchUpInside];
        
        [_button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];

    }
    
    return self;
}

- (void)buttonClicked:(UIButton *)button
{
    button.selected = !button.selected;
    
    self.selected = button.selected;
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)setupDefaultImage
{
    
    [_button setImage:[self defaultImage:YES] forState:UIControlStateNormal];
    
    UIImage *image = [self defaultImage:NO];
    
    [_button setImage:image forState:UIControlStateHighlighted];
    
    [_button setImage:image forState:UIControlStateSelected];
    
    [_button setImage:image forState:UIControlStateSelected|UIControlStateHighlighted];

}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    if (!_imageSetted) {
        
        [self setupDefaultImage];
    }
}

- (void)setContentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment
{
    [super setContentHorizontalAlignment:contentHorizontalAlignment];
    
    [_button setContentHorizontalAlignment:contentHorizontalAlignment];
}

- (void)setContentVerticalAlignment:(UIControlContentVerticalAlignment)contentVerticalAlignment
{
    [super setContentVerticalAlignment:contentVerticalAlignment];
    
    [_button setContentVerticalAlignment:contentVerticalAlignment];
}

- (void)setImage:(UIImage *)image state:(UIControlState)state
{
    if (!_imageSetted) {
        
        [_button setImage:nil forState:UIControlStateNormal];
        
        [_button setImage:nil forState:UIControlStateHighlighted];
        
        [_button setImage:nil forState:UIControlStateSelected];
        
        [_button setImage:nil forState:UIControlStateSelected|UIControlStateHighlighted];
        
        _imageSetted = YES;
    }
 
    [_button setImage:image forState:state];
    
    if (state == UIControlStateHighlighted || state == UIControlStateSelected) {
        
        [_button setImage:image forState:UIControlStateHighlighted];
        
        [_button setImage:image forState:UIControlStateSelected];
        
        [_button setImage:image forState:UIControlStateSelected|UIControlStateHighlighted];
    }
}

- (void)setLabelColor:(UIColor *)color state:(UIControlState)state
{
    [_button setTitleColor:color forState:state];
}

- (void)setLabelText:(NSString *)labelText
{
    [_button setTitle:labelText forState:UIControlStateNormal];
}

- (void)setLabelFont:(UIFont *)font
{
    _button.titleLabel.font = font;
}

- (void)setTintColor:(UIColor *)tintColor
{
    [super setTintColor:tintColor];
    
    if (!_imageSetted) {
        
        [self setupDefaultImage];
    }
}

- (void)setSelected:(BOOL)selected
{
    _button.selected = YES;
}

- (BOOL)selected
{
    return _button.selected;
}

- (UIImage *)defaultImage:(BOOL)normal
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    float scale = [UIScreen mainScreen].scale;
    
    CGSize size = CGSizeMake((self.frame.size.height - 10) * scale,
                             (self.frame.size.height - 10) * scale);
    
    CGContextRef context = CGBitmapContextCreate(NULL, size.width,
                                                 size.height,
                                                 8,
                                                 4 * size.width,
                                                 colorSpace,
                                                 (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    
    CGContextSetFillColorWithColor(context, [self.tintColor CGColor]);
    
    CGContextSetStrokeColorWithColor(context, [self.tintColor CGColor]);

    CGContextSetLineWidth(context, 2);
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    CGContextStrokeEllipseInRect(context, CGRectInset(rect, 2, 2));
    
    if(!normal)
    {
        CGContextFillEllipseInRect(context, CGRectInset(rect, size.width / 3, size.height / 3));
    }
    
    CGImageRef imgDef = CGBitmapContextCreateImage(context);
    
    UIImage *image = [UIImage imageWithCGImage:imgDef scale:scale orientation:UIImageOrientationUp];
    
    CGContextRelease(context);
    
    CGColorSpaceRelease(colorSpace);
    
    CGImageRelease(imgDef);

    return image;
}
@end
