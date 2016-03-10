/**
 *  UIViewController+Base.h
 *  BaseLib
 *
 *  Created by Kevin Chou on 15-4-28.
 *  Copyright (c) 2015年 朱阳勇. All rights reserved.
 *
 *  @note 此类别需要第三方库MBProgressBar和ASIHTTPRequest；
 *        对状态栏进行了处理，默认白色，可重写preferredStatusBarStyle方法
 *        对旋转屏进行了处理，默认支持potrait
 *        处理请求错误可重写- (void)requestFailed:(ASIHTTPRequest *)request方法
 */

#import <UIKit/UIKit.h>

#define kBaseDebug YES

@interface UIViewController (Base)

/**
 *  @breif navigationItem 添加右按钮 对右边距进行处理
 */
- (void)setRightButton:(UIButton *)button;

/**
 *  @breif navigationItem 添加左按钮 对左边距进行处理
 */
- (void)setLeftButton:(UIButton *)button;

/**
 *  @breif 在当前view上显示一个文本信息
 *  @param text 要显示的文本信息
 */
- (void)showToast:(NSString *)text;

/**
 *  @breif 在当前view上显示一个文本信息，延迟消失
 *  @param text  要显示的文本信息
 *  @param delay 延迟消失时间
 */
- (void)showToast:(NSString *)text delay:(float)delay;

/**
 *  @breif 在当前view上显示一个文本信息，消失后执行一个block
 *  @param text  要显示的文本信息
 *  @param completionBlock 消失后执行的block
 */
- (void)showToast:(NSString *)text completionBlock:(void (^)(void))completionBlock;

/**
 *  @breif 隐藏hud指示器
 */
- (void)hideHud;

/**
 *  @breif 显示hud指示器，连接网络时使用
 *  @param text 要显示的信息
 */
- (void)showNetHud:(NSString *)text;

/**
 *  b开头的是使用大视图
 */
- (void)bshowNetHud:(NSString *)text;

- (void)bshowToastErr:(NSString *)text;

- (void)bshowToastInfo:(NSString *)text;

- (void)bshowToastSuc:(NSString *)text completionBlock:(void (^)(void))completionBlock;


/**
 *  @breif 清除所有网络请求，delloc是默认调用
 */
- (void)clearRequest;

@end
