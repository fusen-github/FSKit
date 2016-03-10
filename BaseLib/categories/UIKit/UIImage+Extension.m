//
//  UIImage+Extension.m
//  BaseLib
//
//  Created by Kevin Chou on 14/6/24.
//  Copyright (c) 2014年 nowsilence. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)scaleImage:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * scaleSize, self.size.height * scaleSize));
    
    [self drawInRect:CGRectMake(0, 0, self.size.width * scaleSize, self.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
    
}

- (UIImage *)clipImageFromRect:(CGRect)rect
{
    CGImageRef imageRef = self.CGImage;
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, rect);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, rect, subImageRef);
    
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    
    UIGraphicsEndImageContext();
    
    
    return smallImage;
    
}

- (UIColor *)RGBAColorFromPoint:(CGPoint)point
{
    NSUInteger width = self.size.width * [UIScreen mainScreen].scale;
    
    NSUInteger height = self.size.height * [UIScreen mainScreen].scale;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    
    NSUInteger bytesPerPixel = 4;
    
    NSUInteger bytesPerRow = bytesPerPixel * width;
    
    NSUInteger bitsPerComponent = 8;
    
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0,0,width,height),self.CGImage);
    CGContextRelease(context);
    
    int index = 4*((width*point.y)+point.x);
    int R = rawData[index];
    int G = rawData[index+1];
    int B = rawData[index+2];
    UIColor *aColor;
    aColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0];
//    rValue = R; gValue = G; bValue = B;
    free(rawData);
    
    return aColor;
}

- (UIImage *)flipHorizontal
{
    float scale = self.scale;

    UIImage *image = nil;
    switch (self.imageOrientation) {
        case UIImageOrientationUp:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:UIImageOrientationUpMirrored];
            break;
        }
        case UIImageOrientationDown:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:UIImageOrientationDownMirrored];
            break;
        }
        case UIImageOrientationLeft:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:UIImageOrientationRightMirrored];
            break;
        }
        case UIImageOrientationRight:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:UIImageOrientationLeftMirrored];
            break;
        }
        case UIImageOrientationUpMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:UIImageOrientationUp];
            break;
        }
        case UIImageOrientationDownMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:UIImageOrientationDown];
            break;
        }
        case UIImageOrientationLeftMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:UIImageOrientationRight];
            break;
        }
        case UIImageOrientationRightMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:UIImageOrientationLeft];
            break;
        }
        default:
            break;
    }
    
    return image;
}

- (UIImage*)flipVertical
{
    UIImage *image = nil;
    
    float scale = self.scale;
    
    switch (self.imageOrientation) {
        case UIImageOrientationUp:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:scale orientation:UIImageOrientationDownMirrored];
            break;
        }
        case UIImageOrientationDown:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:scale orientation:UIImageOrientationUpMirrored];
            break;
        }
        case UIImageOrientationLeft:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:scale orientation:UIImageOrientationLeftMirrored];
            break;
        }
        case UIImageOrientationRight:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:scale orientation:UIImageOrientationRightMirrored];
            break;
        }
        case UIImageOrientationUpMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:scale orientation:UIImageOrientationDown];
            break;
        }
        case UIImageOrientationDownMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:scale orientation:UIImageOrientationUp];
            break;
        }
        case UIImageOrientationLeftMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:scale orientation:UIImageOrientationLeft];
            break;
        }
        case UIImageOrientationRightMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:scale orientation:UIImageOrientationRight];
            break;
        }
        default:
            break;
    }
    
    return image;
}


- (UIImage *)scaleToSize:(CGSize)size minBorder:(int)minBorder
{
    float scale = [UIScreen mainScreen].scale;
    
    size.width *= scale;
    
    size.height *= scale;

    float w = CGImageGetWidth(self.CGImage);
    
    float h = CGImageGetHeight(self.CGImage);

    float ratio = size.width / w;
    
    int borderX = minBorder * scale;
    
    int borderY = (size.height - h * ratio) / 2 + borderX;
   
    if (h * ratio > size.height)
    {
        ratio = size.height / h;
        
        borderY = minBorder * scale;
        
        borderX = (size.width  - w * ratio) / 2 + borderY;
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(NULL, size.width,
                                                 size.height,
                                                 8,
                                                 4 * size.width,
                                                 colorSpace,
                                                 (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    
    CGRect r = CGRectMake(borderX, borderY, size.width - 2 * borderX, size.height - 2 * borderY);
    
    CGContextDrawImage(context, r, self.CGImage);
    
    CGImageRef imgDef = CGBitmapContextCreateImage(context);

    UIImage *image = [UIImage imageWithCGImage:imgDef];
    
    CGContextRelease(context);
    
    CGColorSpaceRelease(colorSpace);
    
    CGImageRelease(imgDef);
    
    return image;
}


@end
