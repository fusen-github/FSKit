//
//  FSRefreshHeader.m
//  SDRefreshView
//
//  Created by 四维图新 on 16/3/14.
//  Copyright (c) 2016年 GSD. All rights reserved.
//

#import "FSRefreshHeader.h"

@interface FSRefreshHeader ()
{
    BOOL _hasLayoutedForManuallyRefreshing;
}

@end

@implementation FSRefreshHeader

+ (instancetype)refreshViewWithScrollView:(UIScrollView *)scrollView
{
    return [[self alloc] initWithScrollView:scrollView];
}

- (instancetype)initWithScrollView:(UIScrollView *)scrollView
{
    if (self = [super initWithScrollView:scrollView])
    {
        self.normalInfoText = @"下拉可以刷新";
        
        self.willRefreshInfoText = @"松开立即刷新";
        
        self.isRefreshingInfoText = @"正在刷新...";
        
        self.arrowNormalRadian = 0;
        
        self.arrowWillRefreshRadian = M_PI;
        
        self.refreshViewType = FSRefreshViewTypeHeader;
        
        self.refreshState = FSRefreshStateNormal;
    }
    return self;
}

- (void)beginRefreshWithTarget:(id)target refreshAction:(SEL)action
{
    [super beginRefreshWithTarget:target refreshAction:action];
}

- (void)endRefreshing
{
    [super endRefreshing];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    self.addContentInset = UIEdgeInsetsMake(self.bounds.size.height, 0, 0, 0);
    
}

- (void)beginRefreshWhenViewWillAppear
{
    self.scrollView.contentOffset = CGPointMake(0, -self.bounds.size.height);
    
    [self setRefreshState:FSRefreshStateIsRefreshing];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (![keyPath isEqualToString:kObserveKey] ||
        self.refreshState == FSRefreshStateIsRefreshing) return;
    
    CGFloat y = [change[@"new"] CGPointValue].y;
    
    CGFloat criticalY = -(self.bounds.size.height + self.scrollView.contentInset.top);
    
    if ((y > 0) || (self.scrollView.bounds.size.height == 0)) return;
    
    if (y <= criticalY)
    {
        if (self.scrollView.isDragging)
        {
            if (self.refreshState == FSRefreshStateNormal)
            {
                self.refreshState = FSRefreshStateWillRefresh;
                
                return;
            }
        }
        else
        {
            if (self.refreshState == FSRefreshStateWillRefresh)
            {
                self.refreshState = FSRefreshStateIsRefreshing;
                
                return;
            }
        }
    }
    else
    {
        if (self.scrollView.isDragging)
        {
            if (self.refreshState != FSRefreshStateNormal)
            {
                [self setRefreshState:FSRefreshStateNormal];
            }
        }
        else
        {
            if (self.refreshState == FSRefreshStateWillRefresh)
            {
                [self setRefreshState:FSRefreshStateIsRefreshing];
            }
        }
    }
    
}


// 父控件的frame只要一改变就会调用该函数
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.center = CGPointMake(self.scrollView.bounds.size.width * 0.5, self.bounds.size.height *(-0.5));
}


@end
