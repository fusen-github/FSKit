//
//  UIImage+Utils.h
//  WNCompany
//
//  Created by gaoxin on 15/1/13.
//  Copyright (c) 2015年 SimGao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utils)
/* 等比例缩放 */
- (instancetype)scaleToSize:(CGSize)size;
/* 根据宽度，获取图片尺寸 */
- (CGSize)getScaleSizeByWidth:(CGFloat)width;
/* 将该图片宽、高都缩小在imgLength范围内 */
- (instancetype)scaleImageWithImgLength:(CGFloat)imgLength;

/**
 *  压缩上传图片到指定字节
 *
 *  @param image     压缩的图片
 *  @param maxLength 压缩后最大字节大小
 *
 *  @return 压缩后图片的二进制
 */
+ (NSData *)compressImage:(UIImage *)image toMaxLength:(NSInteger)maxLength;

/* 返回一张可自由拉伸的图片,以中心点为扩展点 */
+ (instancetype)resizedImage:(UIImage *)image;
/* 返回一张可自由拉伸的图片,以左上角点为扩展点 */
+ (instancetype)resizedLeftImage:(UIImage *)image;
@end
