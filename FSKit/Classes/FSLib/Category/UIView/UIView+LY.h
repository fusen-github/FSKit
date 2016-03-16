//
//  UIView+LY.h
//  shuaidanbao
//
//  Created by 吴浪 on 15/12/28.
//  Copyright © 2015年 sdb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LY)
/** 裁剪view的某几个角 */
- (instancetype)cutWithCornerRadius:(CGFloat)radius rectCorner:(UIRectCorner)rectCorner;
@end
