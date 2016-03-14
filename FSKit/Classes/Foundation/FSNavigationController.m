//
//  FSNavigationController.m
//  FSKit
//
//  Created by 四维图新 on 16/3/10.
//  Copyright © 2016年 四维图新. All rights reserved.
//

#import "FSNavigationController.h"

#define IS_IPAD @"定义iPad的宏(用在一个工程中有iPhone和iPad两个target)。该宏在built setting中设置"

@interface FSNavigationController ()

@end

@implementation FSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Navigation

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
#pragma clang diagnostic pop

#pragma mark 旋转控制

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if (IS_IPAD)
    {
        return UIInterfaceOrientationMaskLandscape;
    }
    else
    {
        return UIInterfaceOrientationMaskPortrait;
    }
}


/**
 *  这个方法在写在viewcontroller中，在视图出现之前调用。需要注意一个地方，
 *  如果这个viewcontroller是navigationcontroller容器中的，它将永远不会被调用，
 *  只会调用navigationcontroller中的-(BOOL)shouldAutorotate。
 */
- (BOOL)shouldAutorotate
{
    if (IS_IPAD)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    if (IS_IPAD)
    {
        return [[UIApplication sharedApplication] statusBarOrientation];
    }
    else
    {
        return UIInterfaceOrientationPortrait;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//{
//    return (toInterfaceOrientation == UIDeviceOrientationPortrait);
//    //    return YES;//即在IOS6.0以下版本，支持所用方向的旋屏
//}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    //    [self setMyLayout];//检测到旋转时就会被调用
}







@end
