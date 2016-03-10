//
//  NINavigationController.m
//  FastMap
//
//  Created by 四维图新 on 15/10/19.
//  Copyright (c) 2015年 四维图新. All rights reserved.
//

#import "NINavigationController.h"

@interface NINavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation NINavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak NINavigationController *weakSelf = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
}

-(BOOL)shouldAutorotate
{
    return [[self.viewControllers lastObject] shouldAutorotate];
}

-(NSUInteger)supportedInterfaceOrientations
{
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return [[self.viewControllers lastObject] shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [[self.viewControllers lastObject] preferredStatusBarStyle];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // Hijack the push method to disable the gesture
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = NO;
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animate {
    // Enable the gesture again once the new controller is shown
    self.interactivePopGestureRecognizer.enabled = ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && [self.viewControllers count] > 1);
}
@end
