//
//  FSRefreshFooter.h
//  SDRefreshView
//
//  Created by 四维图新 on 16/3/15.
//  Copyright (c) 2016年 GSD. All rights reserved.
//

#import "FSRefreshView.h"

@interface FSRefreshFooter : FSRefreshView

+ (instancetype)refreshViewWithScrollView:(UIScrollView *)scrollView;

- (instancetype)initWithScrollView:(UIScrollView *)scrollView;

- (void)beginRefreshWithTarget:(id)target refreshAction:(SEL)action;

- (void)endRefreshing;

@end
