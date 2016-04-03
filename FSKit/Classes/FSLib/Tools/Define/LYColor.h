//
//  LYColor.h
//  Floating Window
//
//  Created by 吴浪 on 15/8/24.
//  Copyright (c) 2015年 浪遥. All rights reserved.
//

#ifdef __OBJC__

//RGB颜色
#define LYRGBColor(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 \
                                               green:(g) / 255.0 \
                                                blue:(b) / 255.0 \
                                               alpha:(a) * 1.0]
//随机数
#define LYRandomNumber(n) arc4random_uniform(n)

//随机颜色
#define LYRandomColor MYRGBColor(MYRandomNumber(256), \
                                 MYRandomNumber(256), \
                                 MYRandomNumber(256), 1)

#endif
