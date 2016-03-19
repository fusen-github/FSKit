//
//  UIButton+Extension.h
//  FSBliBli
//
//  Created by 四维图新 on 16/3/19.
//  Copyright © 2016年 四维图新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

/*
 设置imageView和titleLabel之间的间距大小（在设置了image和title之后调用）
 调用位置不受约束
 */
- (void)setImageAndTitleHorizonMargin:(CGFloat)margin;

/*
  将imageView和titleLabel的位置调换，使得imageView在右边，titleLabel在左边
  调用时间：放在最后调用最准确。必要时可放在 layoutSubviews 方法中调用。
          在titleLabel、imageView和button的frame都确定之后再调用。
 */
- (void)setTitleLeftAndImageRightWithHorizonMargin:(CGFloat)margin;

/**
 *  将imageView和titleLabel调成上下结构，使得imageView在上边，titleLabel在下边
 *
 *  @param margin imageView和titleLabel在垂直方向上的间距
 */
- (void)setImageTopAndTitleBottomWithVerticalMargin:(CGFloat)margin;

/**
 *  将imageView和titleLabel调成上下结构，使得imageView在上边，titleLabel在下边
 *
 *  @param margin imageView和titleLabel在垂直方向上的间距
 *  @param space  为了调整titleLabel的水平居中的值。
 */
- (void)setImageTopAndTitleBottomWithVerticalMargin:(CGFloat)margin space:(CGFloat)space;


@end
