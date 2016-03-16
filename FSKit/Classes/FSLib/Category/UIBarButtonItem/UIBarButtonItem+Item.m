//
//  UIBarButtonItem+Item.m
//  茗玥古城
//
//  Created by 似水灵修 on 13-11-11.
//  Copyright (c) 2013年 MingYueGuCheng. All rights reserved.
//  

/*
 注意:需要添加UIButton+Ext.h、UIView+Frame.h分类,
 */
#import "UIBarButtonItem+Item.h"
#import "UIButton+Ext.h"

@implementation UIBarButtonItem (Item)
/**
 *  设置导航栏按钮
 *
 *  @param NormalImageName 普通状态图片
 *  @param highImageName   高亮状态图片
 *  @param action          响应事件
 */
+ (UIBarButtonItem *)itemWithNormalImageName:(NSString *)NormalImageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setNormalBg:NormalImageName highlightedBg:highImageName];
    CGRect rect = btn.frame;
    rect.size = btn.currentBackgroundImage.size;
    btn.frame = rect;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
