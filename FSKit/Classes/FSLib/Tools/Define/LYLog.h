//
//  MYLog.h
//  工具
//
//  Created by 吴浪 on 15/8/8.
//  Copyright (c) 2015年 浪遥. All rights reserved.
//

#ifdef __OBJC__

#ifdef DEBUG

#define NSLog(format, ...) do { \
    fprintf(stderr, "<%s : %d-Line> %s\n", \
    [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], \
    __LINE__, __func__); \
    (NSLog)((format), ##__VA_ARGS__); \
    fprintf(stderr, "--->˚<---\n"); \
} while (0)
#else
#define NSLog(...) {}
#endif

#endif

