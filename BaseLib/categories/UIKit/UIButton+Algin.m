//
//  UIButton+Vertical.m
//  BaseLib
//
//  Created by Kevin Chou on 14/8/10.
//  Copyright (c) 2014年 nowsilence. All rights reserved.
//

#import "UIButton+Algin.h"

@implementation UIButton (Algin)

- (void)horizontalAlgin:(int)spacing
{
//    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
//    self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
    
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

-(void) verticalAlignWithSpace:(int)spacing
{
    CGSize imageSize = self.imageView.image.size;
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (imageSize.height + spacing), 0.0);
    
    CGSize titleSize;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}];
    }
    else
    {
        titleSize = self.titleLabel.frame.size;
    }
    
    self.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), 0.0, 0, - titleSize.width);
}


-(void) verticalAlign
{
//    CGFloat spacing = 2; // the amount of spacing to appear between image and title
//    self.imageView.backgroundColor=[UIColor clearColor];
//    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    self.titleLabel.textAlignment = NSTextAlignmentCenter;
//    // get the size of the elements here for readability
//    CGSize imageSize = self.imageView.frame.size;
//    CGSize titleSize = self.titleLabel.frame.size;
//    
//    // lower the text and push it left to center it
//    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height   + spacing), 0.0);
//    
//    // the text width might have changed (in case it was shortened before due to
//    // lack of space and isn't anymore now), so we get the frame size again
//    titleSize = self.titleLabel.frame.size;
//    
//    // raise the image and push it right to center it
//    self.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), 0.0, 0.0, -     titleSize.width);
    
    
    CGFloat spacing = 2; // the amount of spacing to appear between image and title
    self.imageView.backgroundColor=[UIColor clearColor];
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    // get the size of the elements here for readability
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    // lower the text and push it left to center it
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height   + spacing), 0.0);
    
    // the text width might have changed (in case it was shortened before due to
    // lack of space and isn't anymore now), so we get the frame size again
    titleSize = self.titleLabel.frame.size;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
         self.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), self.frame.size.width / 2, 0.0, -titleSize.width);

    }
    else
        self.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), 0, 0.0, -titleSize.width);

    
    // raise the image and push it right to center it
}
@end
