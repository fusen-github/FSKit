//
//  UIButton+Image.h
//  BaseLib
//
//  Created by Kevin Chou on 15/6/30.
//  Copyright (c) 2015年 nowsilence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Image)

+ (UIButton *)buttonWithImage:(UIImage *)image;

+ (UIButton *)buttonWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage;

@end
