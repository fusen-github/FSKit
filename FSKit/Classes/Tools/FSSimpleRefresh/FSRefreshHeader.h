//
//  FSRefreshHeader.h
//  FSSimpleRefresh
//
//  Created by 四维图新 on 16/3/15.
//  Copyright © 2016年 四维图新. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FSRefreshHeaderBlock)();

@interface FSRefreshHeader : NSObject

+ (instancetype)headerWithScrollView:(UIScrollView *)scrollView;

- (void)beginRefreshWithHeaderBlock:(FSRefreshHeaderBlock)block;

- (void)endHeaderRefreshing;

- (void)beginRefreshWhenViewWillAppear;

@end
