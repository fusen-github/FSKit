//
//  UIImageView+LYExt.m
//  Tools
//
//  Created by 吴浪 on 16/3/11.
//  Copyright © 2016年 吴浪. All rights reserved.
//

#import "UIImageView+LYExt.h"

@implementation UIImageView (LYExt)
+ (instancetype)ly_ImageViewWithImageName:(NSString *)imageName {
    UIImage *image;
    if (imageName.length > 0) {
        image = [UIImage imageNamed:imageName];
    }else {
        image = nil;
    }
    UIImageView *imageView = [[self alloc] initWithImage:image] ;
    return imageView;
}

@end
