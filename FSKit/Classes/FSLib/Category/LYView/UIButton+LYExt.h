//
//  UIButton+LYExt.h
//  Tools
//
//  Created by 吴浪 on 16/3/11.
//  Copyright © 2016年 吴浪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (LYExt)
/**
 *  快速创建button
 *
 *  @param  normalImageName   默认状态图片名
 *  @param  selecteImageName  选择状态图片名
 *  @param  fontSize          字体大小
 *  @param  target            回调对象
 *  @param  selector          回调方法
 *
 *  @return Button      返回Button对象
 */
+ (instancetype)ly_ButtonWithNormalImageName:(NSString *)nImageName
                         selecteImageName:(NSString *)sImageName
                                 fontSize:(CGFloat)fontSize
                                   target:(id)targe
                                 selector:(SEL)selector;

/**
 *  快速创建button
 *
 *  @param  normalImageName   默认状态图片名
 *  @param  selecteImageName  选择状态图片名
 *  @param  target            回调对象
 *  @param  selector          回调方法
 *
 *  @return Button      返回Button对象
 */
+ (instancetype)ly_ButtonWithNormalImageName:(NSString *)nImageName
                         selecteImageName:(NSString *)sImageName
                                   target:(id)targe
                                 selector:(SEL)selector;


@end
