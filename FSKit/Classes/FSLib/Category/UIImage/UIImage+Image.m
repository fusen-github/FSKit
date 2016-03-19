//
//  UIImage+Image.m
//  茗玥古城
//
//  Created by 似水灵修 on 13-11-11.
//  Copyright (c) 2013年 MingYueGuCheng. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)


-(UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect=CGRectMake(0,0, 1, 1);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


/**
 *  返回一张可以随意拉伸不变形的图片
 *
 *  @param name 图片名字
 */
+ (instancetype)resizableImage:(NSString *)name
{
    UIImage *normal = [UIImage imageNamed:name];
    
    CGFloat imageW = normal.self.size.width * 0.5;
    CGFloat imageH = normal.self.size.height * 0.5;
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW)];
}

#pragma mark - 返回一张可自由拉伸的图片
+ (instancetype)resizedImageWithNamed:(NSString *)name
{
    return [self resizedImageWithName:name left:0.5 top:0.5];
}
+ (instancetype)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = MYNewImage(name);
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

#pragma mark - 设置随意拉伸边缘不变形的图片
+ (instancetype)resizableImageNamed:(NSString *)name resizingMode:(UIImageResizingMode)imageResizingMode
{
    UIImage *oldImage = MYNewImage(name);
    
    //图片不进行拉伸部分设定
    CGFloat w = oldImage.size.width * 0.5;
    CGFloat h = oldImage.size.height * 0.5;
    return [oldImage resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w) resizingMode:imageResizingMode];
}

#pragma mark - 屏幕截图
+ (instancetype)captureWithView:(UIView *)view
{
    //开启位图图形上下文
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    
    //屏幕截屏
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //取图
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //结束上下文
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 圆形裁剪
+ (instancetype)circleImageWithNamed:(NSString *)name andBorderWidth:(CGFloat)borderWidth andBorderColor:(UIColor *)borderColor
{
    //加载原图
    UIImage *oldImage = [UIImage imageNamed:name];
    //创建一个基于位图的图形上下文
    CGFloat imageW = oldImage.size.width + 2 * borderWidth;
    CGFloat imageH = oldImage.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    //取得当前图形上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    //绘制背景大圆
    [borderColor setFill];
    CGFloat bigRadius = (imageW < imageH ? imageW : imageH) * 0.5;
    CGFloat centerX = imageW * 0.5;
    CGFloat centerY = imageH * 0.5;
    CGContextAddArc(ref, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ref);
    
    //绘制小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ref, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    //裁剪
    CGContextClip(ref);
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    //取得当前图形上下文中的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //结束图形上下文
    UIGraphicsEndImageContext();
    
    //通过屏幕截图修正处理裁剪完后的图片
    UIImageView *imageView = [[UIImageView alloc] initWithImage:newImage];
    
    CGFloat newImageW = newImage.size.width < newImage.size.height ? newImage.size.width : newImage.size.height;
    //显示区域距边缘的距离
    CGFloat marginX = (newImage.size.width - newImageW) * 0.5;
    CGFloat marginY = (newImage.size.height - newImageW) * 0.5;
    
    CGSize newImageSize = CGSizeMake(newImageW, newImageW);
    
    UIGraphicsBeginImageContextWithOptions(newImageSize, NO, 0.0);
    //平移位图上下文以便获得合理图片
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), -marginX, -marginY);
    [imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - 打水印
+ (instancetype)waterImageWithBgNamed:(NSString *)bg andLogoNamed:(NSString *)logo andLogoPlace:(MYImagePlace)place andLogoScale:(CGFloat)scale
{
    //加载图片
    UIImage *bgImage = [UIImage imageNamed:bg];
    //创建一个基于位图的上下文
    UIGraphicsBeginImageContextWithOptions(bgImage.size, NO, 0.0);
    //背景
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    //绘制水印
    UIImage *waterImage = [UIImage imageNamed:logo];
    CGFloat margin = 5;//距边缘距离
    CGFloat waterW = waterImage.size.width * scale;
    CGFloat waterH = waterImage.size.height * scale;
    CGFloat waterX, waterY;
    switch (place) {
        case MYImagePlaceWithLeftTop:
        {
            waterX = margin;
            waterY = margin;
        }
            break;
        case MYImagePlaceWithLeftBottom:
        {
            waterX = margin;
            waterY = bgImage.size.height - waterH - margin;
        }
            break;
        case MYImagePlaceWithRightTop:
        {
            waterX = bgImage.size.width - waterW - margin;
            waterY = margin;
        }
            break;
        case MYImagePlaceWithRightBottom:
        default:
        {
            waterX = bgImage.size.width - waterW - margin;
            waterY = bgImage.size.height - waterH - margin;
        }
            break;
    }
    [waterImage drawInRect:CGRectMake(waterX, waterY, waterW, waterH)];
    //取得位图图形上下中的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
    
}
@end
