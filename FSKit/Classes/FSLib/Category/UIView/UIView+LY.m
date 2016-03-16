//
//  UIView+LY.m
//  shuaidanbao
//
//  Created by 吴浪 on 15/12/28.
//  Copyright © 2015年 sdb. All rights reserved.
//

#import "UIView+LY.h"

@implementation UIView (LY)
- (instancetype)cutWithCornerRadius:(CGFloat)radius rectCorner:(UIRectCorner)rectCorner {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    return self;
}
@end
