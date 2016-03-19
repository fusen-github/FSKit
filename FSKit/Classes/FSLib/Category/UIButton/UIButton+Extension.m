//
//  UIButton+Extension.m
//  FSBliBli
//
//  Created by 四维图新 on 16/3/19.
//  Copyright © 2016年 四维图新. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)


- (void)setImageAndTitleHorizonMargin:(CGFloat)margin
{
    CGFloat value = margin / 2.0;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0, -value, 0, value);
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0, value, 0, -value);
}


- (void)setTitleLeftAndImageRightWithHorizonMargin:(CGFloat)margin
{
    CGFloat value = margin / 2.0;
    
    CGSize titleSize = self.titleLabel.frame.size;
    
    CGSize imageSize = self.imageView.frame.size;
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
    {
        NSDictionary *dict = @{NSFontAttributeName:self.titleLabel.font};
        
        titleSize = [self.titleLabel.text sizeWithAttributes:dict];
    }
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width - value, 0, imageSize.width + value);

    self.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width + value, 0, -titleSize.width - value);
}


- (void)setImageTopAndTitleBottomWithVerticalMargin:(CGFloat)margin
{
    CGFloat value = margin / 2.0;
    
    CGSize imageSize = self.imageView.frame.size;
    
    CGFloat buttonW = self.frame.size.width;
    
    CGSize titleSize = self.titleLabel.frame.size;
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
    {
        NSDictionary *dict = @{NSFontAttributeName:self.titleLabel.font};
        
        titleSize = [self.titleLabel.text sizeWithAttributes:dict];
    }
    
    CGFloat imgMargin = (buttonW - imageSize.width) * 0.5;
    
    CGFloat titleMargin = (buttonW - titleSize.width) * 0.5;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0, imgMargin, titleSize.height + value, imgMargin);
    
    self.titleEdgeInsets = UIEdgeInsetsMake(imageSize.height + value, -titleMargin+5, 0, titleMargin-5);
}


- (void)setImageTopAndTitleBottomWithVerticalMargin:(CGFloat)margin space:(CGFloat)space
{
    CGFloat value = margin / 2.0;
    
    CGSize imageSize = self.imageView.frame.size;
    
    CGFloat buttonW = self.frame.size.width;
    
    CGSize titleSize = self.titleLabel.frame.size;
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
    {
        NSDictionary *dict = @{NSFontAttributeName:self.titleLabel.font};
        
        titleSize = [self.titleLabel.text sizeWithAttributes:dict];
    }
    
    CGFloat imgMargin = (buttonW - imageSize.width) * 0.5;
    
    CGFloat titleMargin = (buttonW - titleSize.width) * 0.5;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0, imgMargin, titleSize.height + value, imgMargin);
    
    self.titleEdgeInsets = UIEdgeInsetsMake(imageSize.height + value, -titleMargin + space, 0, titleMargin-space);
}





@end
