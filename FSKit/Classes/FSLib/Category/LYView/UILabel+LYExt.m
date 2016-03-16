//
//  UILabel+LYExt.m
//  Tools
//
//  Created by 吴浪 on 16/3/11.
//  Copyright © 2016年 吴浪. All rights reserved.
//

#import "UILabel+LYExt.h"

@implementation UILabel (LYExt)
+ (instancetype)ly_LabelWithTitle:(NSString *)title fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor {
    UILabel *label = [[self alloc] init];
    label.textColor = titleColor;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.text = title;
    return label;
}
@end
