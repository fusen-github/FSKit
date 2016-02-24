//
//  UIAlertView+Additional.m
//  BaseKit
//
//  Created by Nigel Chou on 15/11/9.
//  Copyright (c) 2015年 BeautyFuture. All rights reserved.
//

#import "UIAlertView+Additional.h"
#import "objc/runtime.h"

@implementation UIAlertView (Additional)

- (id)additional {
    return objc_getAssociatedObject(self, @selector(additional));
}

- (void)setAdditional:(id)value {
    objc_setAssociatedObject(self, @selector(additional), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
