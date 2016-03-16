//
//  UIButton+Ext.m
//  茗玥古城
//
//  Created by 似水灵修 on 13-11-11.
//  Copyright (c) 2013年 MingYueGuCheng. All rights reserved.
//  
/*
 注意:需要添加UIImage+Image分类,
 */

#import "UIButton+Ext.h"
#import "UIImage+Image.h"

@implementation UIButton (Ext)
/************* 背景 *************/
/**
 *  设置未拉伸的正常状态背景图片
 */
- (void)setNormalBg:(NSString *)normalBg
{
    [self setBackgroundImage:MYNewImage(normalBg) forState:UIControlStateNormal];
}
/**
 *  设置未拉伸的高亮状态背景图片
 */
- (void)setHighlightedBg:(NSString *)highlightedBg
{
    [self setBackgroundImage:MYNewImage(highlightedBg) forState:UIControlStateHighlighted];
}
/**
 *  设置未拉伸的正常和高亮状态背景图片
 *
 *  @param normalBg    正常状态的背影图片
 *  @param highlightedBg 高亮状态的背影图片
 */
- (void)setNormalBg:(NSString *)normalBg highlightedBg:(NSString *)highlightedBg
{
    [self setNormalBg:normalBg];
    [self setHighlightedBg:highlightedBg];
}
/**
 *  设置拉伸的正常状态背景图片
 */
- (void)setResizedNormalBg:(NSString *)normalBg
{
    [self setBackgroundImage:[UIImage resizedImageWithNamed:normalBg] forState:UIControlStateNormal];
}
/**
 *  设置拉伸的高亮状态背景图片
 */
- (void)setResizedHighlightedBg:(NSString *)highlightedBg
{
    [self setBackgroundImage:[UIImage resizedImageWithNamed:highlightedBg] forState:UIControlStateHighlighted];
}
/**
 *  设置拉伸的正常和高亮状态背景图片
 *
 *  @param normalBg    正常状态的背影图片
 *  @param highlightedBg 高亮状态的背影图片
 */
- (void)setResizedNormalBg:(NSString *)normalBg highlightedBg:(NSString *)highlightedBg
{
    [self setResizedNormalBg:normalBg];
    [self setResizedHighlightedBg:highlightedBg];
}
/**
 *  设置未拉伸的选中状态背影图片
 */
- (void)setSelectedBg:(NSString *)selectedBg
{
    [self setBackgroundImage:MYNewImage(selectedBg) forState:UIControlStateSelected];
}
/**
 *  设置未拉伸的正常和选中状态背景图片
 *
 *  @param normalBg    正常状态的背影图片
 *  @param selectedBg 选中状态的背影图片
 */
- (void)setNormalBg:(NSString *)normalBg selectedBg:(NSString *)selectedBg
{
    [self setNormalBg:normalBg];
    [self setSelectedBg:selectedBg];
}
/**
 *  设置拉伸的选中状态背影图片
 */
- (void)setResizedSelectedBg:(NSString *)selectedBg
{
    [self setBackgroundImage:[UIImage resizedImageWithNamed:selectedBg] forState:UIControlStateSelected];
}
/**
 *  设置拉伸的正常和选中状态背景图片
 *
 *  @param normalBg    正常状态的背影图片
 *  @param selectedBg 选中状态的背影图片
 */
- (void)setResizedNormalBg:(NSString *)normalBg selectedBg:(NSString *)selectedBg
{
    [self setResizedNormalBg:normalBg];
    [self setResizedSelectedBg:selectedBg];
}
/***********背景（完）*************/
/************* 图标 *************/
/**
 *  设置未拉伸的正常状态的Image图标
 */
- (void)setNormalImage:(NSString *)normalImage
{
    [self setImage:MYNewImage(normalImage) forState:UIControlStateNormal];
}
/**
 *  设置未拉伸的高亮状态的Image图标
 */
- (void)setHighlightedImage:(NSString *)highlightedImage
{
    [self setImage:MYNewImage(highlightedImage) forState:UIControlStateHighlighted];
}
/**
 *  设置未拉伸的选中状态的Image图标
 */
- (void)setSelectedImage:(NSString *)selectedImage
{
    [self setImage:MYNewImage(selectedImage) forState:UIControlStateSelected];
    
}
/**
 *  设置未拉伸的正常和高亮状态的Image图标
 */
- (void)setNormalImage:(NSString *)normalImage highlightedImage:(NSString *)highlightedImage
{
    [self setNormalImage:normalImage];
    [self setHighlightedImage:highlightedImage];
}
/**
 *  设置未拉伸的正常和选中状态的Image图标
 */
- (void)setNormalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage
{
    [self setNormalImage:normalImage];
    [self setSelectedImage:selectedImage];
}
/************* 图标 （完）*************/
/**
 *  设置正常状态的title文字
 */
- (void)setNormalTitle:(NSString *)normalTitle
{
    [self setTitle:normalTitle forState:UIControlStateNormal];
}
/**
 *  设置正常状态的color颜色
 */
- (void)setNormalTitleColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateNormal];
}

@end
