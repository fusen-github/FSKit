//
//  UIImage+Extension.h
//  BaseLib
//
//  Created by Kevin Chou on 14/6/24.
//  Copyright (c) 2014年 nowsilence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+ (UIImage *)imageWithColor:(UIColor *)color;
- (UIColor *)RGBAColorFromPoint:(CGPoint)point;
- (UIImage *)clipImageFromRect:(CGRect)rect;
- (UIImage*)flipHorizontal;
- (UIImage *)scaleImage:(float)scaleSize;
- (UIImage*)flipVertical;
- (UIImage *)scaleToSize:(CGSize)size minBorder:(int)minBorder;

@end
