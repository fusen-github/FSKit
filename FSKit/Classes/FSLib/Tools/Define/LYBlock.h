//
//  LYBlock.h
//  Floating Window
//
//  Created by 吴浪 on 15/8/24.
//  Copyright (c) 2015年 浪遥. All rights reserved.
//

#ifdef __OBJC__

/* block代码块 */
typedef void(^LYOperateBlock)(); /*< 无参数 */
typedef void(^LYBlock)(id object); /*< 有参数 */

/** IMP宏 */
typedef id (*_IMP) (id, SEL, ...);
typedef void (*_VIMP) (id, SEL, ...);

#endif