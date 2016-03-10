//
//  UIViewController+Base.m
//  小说搜搜看
//
//  Created by Kevin Chou on 15-4-28.
//  Copyright (c) 2015年 com.nowsilence.sousou. All rights reserved.
//

#import "UIViewController+Base.h"
#import "MBProgressHUD.h"
#import "ASIHTTPRequest.h"
#import "HudResource.h"
#import "GTMBase64.h"

@implementation UIViewController (Base)

- (void)setLeftButton:(UIButton *)button
{
    if (!button)
    {
        self.navigationItem.leftBarButtonItems = nil;
        self.navigationItem.leftBarButtonItem = nil;
        
        return;
    }
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        UIBarButtonItem *negativeSeperator =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                      target:nil
                                                      action:nil];
        negativeSeperator.width = -16;
        
        [self.navigationItem setLeftBarButtonItems:@[negativeSeperator, leftBarButtonItem]];
    }
    else
    {
        [self.navigationItem setLeftBarButtonItem:leftBarButtonItem animated:NO];
    }
}

- (void)setRightButton:(UIButton *)button
{
    if (!button)
    {
        self.navigationItem.rightBarButtonItems = nil;
        self.navigationItem.rightBarButtonItem = nil;
        
        return;
    }
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        UIBarButtonItem *negativeSeperator =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                      target:nil
                                                      action:nil];
        negativeSeperator.width = -16;
        
        [self.navigationItem setRightBarButtonItems:@[negativeSeperator, rightBarButtonItem]];
    }
    else
    {
        [self.navigationItem setRightBarButtonItem:rightBarButtonItem animated:NO];
    }
}

#pragma mark 显示提示信息
- (void)showToast:(NSString *)text delay:(float)delay
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
    
    if (!hud)
    {
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.removeFromSuperViewOnHide = YES;
    }
    else
    {
        [hud cancelHideDelayed];
    }
    
    hud.padding = 5;
    
    hud.minSize = CGSizeZero;
    
    hud.mode = MBProgressHUDModeText;
    
    hud.detailsLabelText = text;
    
    [hud hide:YES afterDelay:delay];
    
    hud.labelText = nil;
}

- (void)showToast:(NSString *)text
{
    [self showToast:text delay:1];
}

- (void)showToast:(NSString *)text completionBlock:(void (^)(void))completionBlock
{
    double delayInSeconds = 2.f;
    
    [self  showToast:text delay:delayInSeconds];
    
    delayInSeconds -= 1;
    
    if (completionBlock)
    {
        if (delayInSeconds > 0) {
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                completionBlock();
            });
        }
        else
        {
            completionBlock();
        }
    }
}

- (void)showNetHud:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
    
    if (!hud)
    {
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.removeFromSuperViewOnHide = YES;
    }
    else
    {
        [hud cancelHideDelayed];
    }
    
    hud.padding = 5;
    
    hud.minSize = CGSizeZero;
    
    hud.mode = MBProgressHUDModeIndeterminate;
    
    hud.detailsLabelText = text;
    
    hud.labelText = nil;
}

- (void)bshowNetHud:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
    
    if (!hud)
    {
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.removeFromSuperViewOnHide = YES;
    }
    else
    {
        [hud cancelHideDelayed];
    }
    
    hud.mode = MBProgressHUDModeIndeterminate;
    
    hud.indicatorLarge = YES;
    
    hud.padding = 24;
    
    hud.minSize = CGSizeMake(150, 150);
    
    hud.labelText = text;
    
    hud.detailsLabelText = nil;
}

- (void)bshowToastErr:(NSString *)text
{
    NSData *data = [GTMBase64 decodeString:ErrImage];

    UIImage *image = [UIImage imageWithData:data scale:2];
    
    [self bshowToast:text image:image delay:2];
}

- (void)bshowToastInfo:(NSString *)text
{
    NSData *data = [GTMBase64 decodeString:InfoImage];
    
    UIImage *image = [UIImage imageWithData:data scale:2];
    
    [self bshowToast:text image:image delay:1];
}

- (void)bshowToastSuc:(NSString *)text completionBlock:(void (^)(void))completionBlock
{
    NSData *data = [GTMBase64 decodeString:SucImage];
    
    UIImage *image = [UIImage imageWithData:data scale:2];
    
    double delayInSeconds = 2.f;
    
    [self bshowToast:text image:image delay:delayInSeconds];
    
    delayInSeconds -= 1;
    
    if (completionBlock)
    {
        if (delayInSeconds > 0) {
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                completionBlock();
            });
        }
        else
        {
            completionBlock();
        }
    }
   
}

- (void)bshowToast:(NSString *)text image:(UIImage *)image delay:(float)delay
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];

    if (!hud)
    {
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.removeFromSuperViewOnHide = YES;
    }
    else
    {
        [hud cancelHideDelayed];
    }
    
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.customView = [[UIImageView alloc] initWithImage:image];
    
    hud.padding = 24;
    
    hud.minSize = CGSizeMake(150, 150);
    
    hud.labelText = text;
    
    hud.detailsLabelText = nil;
    
    [hud hide:YES afterDelay:delay];
}

- (void)hideHud
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
    
    if (hud)
    {
        [hud hide:YES];
    }
}

#pragma mark 旋转控制

-(NSUInteger)supportedInterfaceOrientations
{
    //    [self setMyLayout];
    return UIInterfaceOrientationMaskPortrait;
}

/**
 *  这个方法在写在viewcontroller中，在视图出现之前调用。需要注意一个地方，
 *  如果这个viewcontroller是navigationcontroller容器中的，它将永远不会被调用，
 *  只会调用navigationcontroller中的-(BOOL)shouldAutorotate。
 */
- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    //    [self setMyLayout];//检测到旋转时就会被调用
}

/**
 *  为了兼容IOS6以前的版本而保留的方法
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIDeviceOrientationPortrait);
    //    return YES;//即在IOS6.0以下版本，支持所用方向的旋屏
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma clang diagnostic pop

#pragma mark 清除未完成的网络请求
- (void)clearRequest
{
    for (ASIHTTPRequest *request in [ASIHTTPRequest sharedQueue].operations)
    {
        NSString *description = [request.userInfo objectForKey:@"description"];
        
        if ([description isEqualToString:[self description]])
        {
            request.userInfo = nil;
            
            [request clearDelegatesAndCancel];
        }
    }
}

/**
 *  需要自己处理可重写
 */
- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self showToast:@"网络异常，请检查网络后重试！"];
}

/**
 *  不可覆盖，会crash，
 */
//- (void)dealloc
//{
////    if(kBaseDebug) NSLog(@"%@ dealloc",[self class]);
////    
////    [self clearRequest];
//}

@end
