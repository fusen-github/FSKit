//
//  NCCheckBox.h
//  CheckBox
//
//  gitHub:https://github.com/nowsilence/uiDemo/tree/master/CheckBox
//
//  Created by Nigel Chou on 16/1/28.
//  Copyright (c) 2016年 BeautyFuture. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NCCheckBox : UIControl

@property(nonatomic,strong) NSString *labelText;


- (void)setImage:(UIImage *)image state:(UIControlState)state;

- (void)setLabelColor:(UIColor *)color state:(UIControlState)state;

- (void)setLabelFont:(UIFont *)font;
@end
