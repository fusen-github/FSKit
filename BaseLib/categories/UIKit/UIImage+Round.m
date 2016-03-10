//
//  UIImage+Round.m
//  BaseLib
//
//  Created by Kevin Chou on 14-8-19.
//  Copyright (c) 2014年 nowsilence. All rights reserved.
//

#import "UIImage+Round.h"
#import "KCMicro.h"

@implementation UIImage (Round)

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
                                 float ovalHeight)
{
    float fw, fh;
    
    if (ovalWidth == 0 || ovalHeight == 0)
    {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
//    CGAffineTransformMakeScale([UIScreen mainScreen].scale, [UIScreen mainScreen].scale);
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

- (UIImage *)circleImage:(int)size color:(UIColor *)color borderWidth:(int)borderWidth
{
    int w = size * [UIScreen mainScreen].scale;
    int h = size * [UIScreen mainScreen].scale;
    
    int r = size * [UIScreen mainScreen].scale / 2;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextAddArc(context, size, size, r, 0, M_PI * 2, 0);
    CGContextFillPath(context);
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context, CGRectInset(rect, borderWidth, borderWidth), r - borderWidth, r - borderWidth);
    CGContextClosePath(context);
    CGContextClip(context);
    
    
    
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillRect(context, CGRectMake(0,0,w,h));
    CGContextDrawImage(context, CGRectMake(borderWidth, borderWidth, w - borderWidth * 2, h - borderWidth * 2), self.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    UIImage *img = [UIImage imageWithCGImage:imageMasked scale:[UIScreen mainScreen].scale orientation:self.imageOrientation];
    
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);
    
    return img;
}

- (id)roundedImageWithSize:(CGSize)size radius:(NSInteger)r
{
    int w = size.width * [UIScreen mainScreen].scale;
    
    int h = size.height * [UIScreen mainScreen].scale;
    
//    r = r * [UIScreen mainScreen].scale;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias(context, YES);
    
    CGRect rect = CGRectMake(0, 0, w, h);

    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                    cornerRadius:rect.size.width / 2];
    CGContextBeginPath(context);
    
//    addRoundedRectToPath(context, rect, r, r);
    CGContextAddPath(context, [path CGPath]);
    
    CGContextClosePath(context);
    
    CGContextClip(context);
    
    
    
//    CGContextSetFillColorWithColor(context, UIColorFromRGB(0xfe6f36).CGColor);
//    
//    CGContextFillRect(context, CGRectMake(0,0,w,h));
    
    CGContextDrawImage(context, CGRectMake(-1, -1, w + 2, h + 2), self.CGImage);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    
    UIImage *img = [UIImage imageWithCGImage:imageMasked
                                       scale:[UIScreen mainScreen].scale
                                 orientation:self.imageOrientation];
    CGContextRelease(context);
    
    CGColorSpaceRelease(colorSpace);
    
    CGImageRelease(imageMasked);
    
    return img;
}
@end
