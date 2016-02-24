//
//  UIButton+Extension.m
//  BaseLib
//
//  Created by Kevin Chou on 15/10/31.
//  Copyright (c) 2015年 navinfo. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

- (void)horizontalAlgin:(int)spacing
{
    CGFloat insetAmount = spacing / 2.0;
 
    self.imageEdgeInsets = UIEdgeInsetsMake(0, -insetAmount, 0, insetAmount);
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, -insetAmount);
}

-(void) verticalAlignWithSpace:(int)spacing topSpacing:(int)topSpacing
{
    CGSize imageSize = self.imageView.image.size;
    
    self.titleEdgeInsets = UIEdgeInsetsMake(topSpacing,
                                            - imageSize.width,
                                            - (imageSize.height + spacing + topSpacing),
                                            0.0);
    
    CGSize titleSize;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}];
    }
    else
    {
        titleSize = self.titleLabel.frame.size;
    }
    
    self.imageEdgeInsets = UIEdgeInsetsMake(topSpacing - (titleSize.height + spacing),
                                            0.0,
                                            -topSpacing,
                                            - titleSize.width);
}
@end
