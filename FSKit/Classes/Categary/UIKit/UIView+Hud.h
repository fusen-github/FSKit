//
//  UIView+Hud.h
//  BaseLib
//
//  Created by Nigel Chou on 16/3/14.
//  Copyright (c) 2016年 BeautyFuture. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NCHudState) {
  
    NCHudStateLoading   = 0,    /// 正在加载
    NCHudStateErr       = 1,    /// 加载失败
    NCHudStateNothing   = 2,    /// 没有数据
    NCHudStateRemove    = 3     /// 移除
};

@interface UIView (Hud)

- (void)nck_setHudState:(NCHudState)state;

/**
 *  @brief 设置hud状态
 *  @param state 状态
 *  @param hudImage 状态提示图片，可为nil
 */
- (void)nck_setHudState:(NCHudState)state hudImage:(UIImage *)image;

/**
 *  @brief 当加载失败/加载数据为空，用户点击
 *  的时候调用，一般用来重载
 *  @param insets hud四边距
 */
- (void)nck_setOnTapBlock:(void (^)(NCHudState state))block;
/**
 *  @brief 
 *  @param insets hud四边距
 */
- (void)nck_setHudInsets:(UIEdgeInsets)insets;

/**
 *  @brief 设置对应状态下的文字
 */
- (void)nck_setInfoText:(NSString *)text hudState:(NCHudState)state;

/**
 *  @brief 设置文字的字体
 */
- (void)nck_setFont:(UIFont *)font;

/**
 *  @brief 设置文字的颜色
 */
- (void)nck_setLabelTextColor:(UIColor *)color;

/**
 *  @brief 设置文字的阴影颜色
 */
- (void)nck_setLabelShadowColor:(UIColor *)color;

/**
 *  @brief 设置提示图片和文字之间的间距
 *  @param padding 间距
 */
- (void)nck_setPaddingBetweenImageAndText:(int)padding;

@end
