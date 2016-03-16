//
//  UIImageView+LYExt.h
//  Tools
//
//  Created by 吴浪 on 16/3/11.
//  Copyright © 2016年 吴浪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LYExt)
/**
 *  快速创建ImageView
 *
 *  @param  imageNamed  图片名
 *
 *  @return ImageView  返回ImageView对象
 */
+ (instancetype)ly_ImageViewWithImageName:(NSString *)imageName;
@end
