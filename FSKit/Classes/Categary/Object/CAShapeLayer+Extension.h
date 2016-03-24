//
//  CAShapeLayer+Extension.h
//  FSQQZone
//
//  Created by 四维图新 on 16/3/24.
//  Copyright © 2016年 四维图新. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

/*
 
用法：
 
 UIView *view = [[UIView alloc] init];
 
 view.frame = CGRectMake(100, 200, 200, 300);
 
 view.backgroundColor = [UIColor redColor];
 
 [self.view addSubview:view];
 
 CAShapeLayer *shapLayer = [CAShapeLayer createMaskLayerWithView:view];
 
 view.layer.mask = shapLayer;
 
 */

@interface CAShapeLayer (Extension)

+ (instancetype)createMaskLayerWithView:(UIView *)view;

@end









