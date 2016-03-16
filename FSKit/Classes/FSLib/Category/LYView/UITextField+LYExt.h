//
//  UITextField+LYExt.h
//  Tools
//
//  Created by 吴浪 on 16/3/11.
//  Copyright © 2016年 吴浪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (LYExt)
/**
 *  快速创建TextField
 *
 *  @param  placeholder  占位符
 *  @param  fontSize     字体大小
 *
 *  @return TextField  返回TextField对象
 */
+ (instancetype)ly_TextFieldWithPlaceholder:(NSString *)placeholder fontSize:(CGFloat)fontSize;
@end
