//
//  UIBarButtonItem+Item.h
//  茗玥古城
//
//  Created by 似水灵修 on 13-11-11.
//  Copyright (c) 2013年 MingYueGuCheng. All rights reserved.

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)
/**
 *  设置导航栏按钮
 *
 *  @param NormalImageName 普通状态图片
 *  @param highImageName   高亮状态图片
 *  @param action          响应事件
 */
+ (UIBarButtonItem *)itemWithNormalImageName:(NSString *)NormalImageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;

@end
