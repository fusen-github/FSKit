//
//  UIButton+Ext.h
//  茗玥古城
//
//  Created by 似水灵修 on 13-11-11.
//  Copyright (c) 2013年 MingYueGuCheng. All rights reserved.
//
 
#import <UIKit/UIKit.h>
@interface UIButton (Ext)
/************* 背景 *************/

/**
 *  设置未拉伸的正常状态背景图片
 */
- (void)setNormalBg:(NSString *)normalBg;
/**
 *  设置未拉伸的高亮状态背景图片
 */
- (void)setHighlightedBg:(NSString *)highlightedBg;
/**
 *  设置未拉伸的正常和高亮状态背景图片
 *
 *  @param normalBg    正常状态的背影图片
 *  @param highlightedBg 高亮状态的背影图片
 */
- (void)setNormalBg:(NSString *)normalBg highlightedBg:(NSString *)highlightedBg;
/**
 *  设置拉伸的正常状态背景图片
 */
- (void)setResizedNormalBg:(NSString *)normalBg;
/**
 *  设置拉伸的高亮状态背景图片
 */
- (void)setResizedHighlightedBg:(NSString *)highlightedBg;
/**
 *  设置拉伸的正常和高亮状态背景图片
 *
 *  @param normalBg    正常状态的背影图片
 *  @param highlightedBg 高亮状态的背影图片
 */
- (void)setResizedNormalBg:(NSString *)normalBg highlightedBg:(NSString *)highlightedBg;
/**
 *  设置未拉伸的选中状态背影图片
 */
- (void)setSelectedBg:(NSString *)selectedBg;
/**
 *  设置拉伸的选中状态背影图片
 */
- (void)setResizedSelectedBg:(NSString *)selectedBg;
/**
 *  设置未拉伸的正常和选中状态背景图片
 *
 *  @param normalBg    正常状态的背影图片
 *  @param selectedBg  选中状态的背影图片
 */
- (void)setNormalBg:(NSString *)normalBg selectedBg:(NSString *)selectedBg;
/**
 *  设置拉伸的正常和选中状态背景图片
 *
 *  @param normalBg    正常状态的背影图片
 *  @param selectedBg  选中状态的背影图片
 */
- (void)setResizedNormalBg:(NSString *)normalBg selectedBg:(NSString *)selectedBg;
/***********背景（完）*************/
/************* 图标 *************/

/**
 *  设置未拉伸的正常状态的Image图标
 */
- (void)setNormalImage:(NSString *)normalImage;
/**
 *  设置未拉伸的高亮状态的Image图标
 */
- (void)setHighlightedImage:(NSString *)highlightedImage;
/**
 *  设置未拉伸的选中状态的Image图标
 */
- (void)setSelectedImage:(NSString *)selectedImage;
/**
 *  设置未拉伸的正常和高亮状态的Image图标
 */
- (void)setNormalImage:(NSString *)normalImage highlightedImage:(NSString *)highlightedImage;
/**
 *  设置未拉伸的正常和选中状态的Image图标
 */
- (void)setNormalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage;
/************* 图标 （完）*************/

/**
 *  设置正常状态的title文字
 */
- (void)setNormalTitle:(NSString *)normalTitle;
/**
 *  设置正常状态的color颜色
 */
- (void)setNormalTitleColor:(UIColor *)color;
@end
