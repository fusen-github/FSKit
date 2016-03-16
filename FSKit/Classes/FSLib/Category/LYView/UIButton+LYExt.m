//
//  UIButton+LYExt.m
//  Tools
//
//  Created by 吴浪 on 16/3/11.
//  Copyright © 2016年 吴浪. All rights reserved.
//

#import "UIButton+LYExt.h"

@implementation UIButton (LYExt)

+ (instancetype)ly_ButtonWithNormalImageName:(NSString *)nImageName selecteImageName:(NSString *)sImageName fontSize:(CGFloat)fontSize target:(id)targe selector:(SEL)selector {
    
    UIImage *nImage;
    UIImage *sImage;
    if (nImageName.length > 0) {
        nImage = [UIImage imageNamed:nImageName];
    }else {
        nImage = nil;
    }
    if (sImageName.length > 0) {
        sImage = [UIImage imageNamed:sImageName];
    }else {
        sImage = nil;
    }
    UIButton *btn = [self buttonWithType:UIButtonTypeCustom];
    if (fontSize != NSNotFound) {
        btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    [btn setImage:nImage forState:UIControlStateNormal];
    [btn setImage:sImage forState:UIControlStateSelected];
    [btn addTarget:targe action:selector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (instancetype)ly_ButtonWithNormalImageName:(NSString *)nImageName selecteImageName:(NSString *)sImageName target:(id)targe selector:(SEL)selector {
    return [self ly_ButtonWithNormalImageName:nImageName selecteImageName:sImageName fontSize:NSNotFound target:targe selector:selector];
}
@end
