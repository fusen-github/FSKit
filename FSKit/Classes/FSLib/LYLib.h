//
//  LYLib.h
//  茗玥古城
//
//  Created by 似水灵修 on 13-11-11.
//  Copyright (c) 2013年 MingYueGuCheng. All rights reserved.
//

/**
茗玥古城 iOS SDK(工具类)

-------------------------------------------------------------------------------------

iOS 工具类 SDK v1.0.0是适用于iOS系统移动设备开发包

--------------------------------------------------------------------------------------
 
LYLib SDK功能介绍（全功能开发包）：

Category文件：提供基础常用分类。

Toos文件：提供常用工具类。

注意：
1、LYLib.h文件中已经导入了Category文件中所有的常用工具类
2、LYLib.h文件只导入了Toos文件中部分工具类，如果需要请自行添加相应头文件

特色功能：已集成大量常用类，提高开发效率。

--------------------------------------------------------------------------------------
 
注意：使用时，请开发者添加LYLib文件包，并导入LYLib.h头文件。

---------------------------------------------------------------------------------------
 
【新版提示】


【新 增 / 废 弃】


【 修 复】

*/
/*****************************************************/


#ifdef __OBJC__
#pragma mark - 常用工具类(注意：只导入Tools文件内部分工具类，如需其他类自行导入文件)
#import "LYLog.h"
#import "LYBlock.h"
#import "LYColor.h"


#pragma mark - 常用分类(注意：已导入Category文件内所有分类)
#import "LYCategory.h"


#endif
