//
//  UILabel+LYExt.h
//  Tools
//
//  Created by 吴浪 on 16/3/11.
//  Copyright © 2016年 吴浪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LYExt)
/**
 *  快速创建Label
 *
 *  @param  title       title
 *  @param  fontSize    字体大小
 *  @param  titleColor  字体颜色
 *
 *  @return Label  返回Label对象
 */
+ (instancetype)ly_LabelWithTitle:(NSString *)title
                      fontSize:(CGFloat)fontSize
                    titleColor:(UIColor *)titleColor;
@end
