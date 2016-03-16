//
//  UITextField+LYExt.m
//  Tools
//
//  Created by 吴浪 on 16/3/11.
//  Copyright © 2016年 吴浪. All rights reserved.
//

#import "UITextField+LYExt.h"

@implementation UITextField (LYExt)
+ (instancetype)ly_TextFieldWithPlaceholder:(NSString *)placeholder fontSize:(CGFloat)fontSize {
    UITextField *textField = [[self alloc] init];
    textField.placeholder = placeholder;
    textField.font = [UIFont systemFontOfSize:fontSize];
    return textField;
}
@end
