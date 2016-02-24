//
//  NSString+Path.h
//  测试分类
//
//  Created by 四维图新 on 15/11/26.
//  Copyright (c) 2015年 四维图新. All rights reserved.
//

/**
 *  利用改分类可以直接根据文件名，来创建文件的沙盒路径。
 *  常用于，保存数据到本地时获取沙盒目录。
 *  eg：可用于 1、数组、字典 writeToFile 
             2、 自定义对象归档、解档
 */

#import <Foundation/Foundation.h>

@interface NSString (Path)

- (NSString *)appendingDocumentPath;

- (NSString *)appendingCachePath;

- (NSString *)appendingTmpPath;

@end
