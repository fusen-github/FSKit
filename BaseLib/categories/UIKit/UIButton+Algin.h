//
//  UIButton+Vertical.h
//  BaseLib
//
//  Created by Kevin Chou on 14/8/10.
//  Copyright (c) 2014年 nowsilence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Algin)
-(void) verticalAlign;

-(void) verticalAlignWithSpace:(int)spacing;

-(void) verticalAlignWithSpace:(int)spacing topSpacing:(int)topSpacing;

- (void)horizontalAlgin:(int)spacing;
@end
