//
//  UIImage+Round.h
//  BaseLib
//
//  Created by Kevin Chou on 14-8-19.
//  Copyright (c) 2014年 nowsilence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Round)

- (id)roundedImageWithSize:(CGSize)size radius:(NSInteger)r;

- (UIImage *)circleImage:(int)size color:(UIColor *)color borderWidth:(int)borderWidth;

@end
