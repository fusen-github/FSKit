//
//  NCLineButton.h
//  lineButton
//
//  https://github.com/nowsilence/uiDemo/tree/master/lineButton
//
//  Created by Nigel Chou on 15/12/20.
//  Copyright (c) 2015年 BeautyFuture. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NCLineButton : UIControl

@property(nonatomic) float cornerRadius;

@property(nonatomic) float lineWidth;

@property(nonatomic,strong) UIFont *titleFont;

- (void)setTitle:(NSString *)title forState:(UIControlState)state;

- (void)setColor:(UIColor *)color forState:(UIControlState)state;

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end
