//
//  FSRefreshFooter.m
//  SDRefreshView
//
//  Created by 四维图新 on 16/3/15.
//  Copyright (c) 2016年 GSD. All rights reserved.
//

#import "FSRefreshFooter.h"

@interface FSRefreshFooter ()

@property (nonatomic, assign) CGFloat scrollViewOriginContentHeight;

@property (nonatomic, assign) UIEdgeInsets originEdgeInset;

@property (nonatomic, assign) BOOL isFilled;

@end

@implementation FSRefreshFooter

+ (instancetype)refreshViewWithScrollView:(UIScrollView *)scrollView
{
    return [[self alloc] initWithScrollView:scrollView];
}

- (instancetype)initWithScrollView:(UIScrollView *)scrollView
{
    if (self = [super initWithScrollView:scrollView])
    {
        self.normalInfoText = @"上拉可以加载更多";
        
        self.willRefreshInfoText = @"松开立即加载";
        
        self.isRefreshingInfoText = @"正在加载...";
        
        self.arrowNormalRadian = M_PI;
        
        self.arrowWillRefreshRadian = 0;
        
        self.refreshViewType = FSRefreshViewTypeFooder;
        
        self.refreshState = FSRefreshStateNormal;
        
        self.scrollViewOriginContentHeight = scrollView.contentSize.height;
        
        self.originEdgeInset = self.scrollView.contentInset;
        
        self.isFilled = NO;
        
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    self.addContentInset = UIEdgeInsetsMake(0, 0, self.bounds.size.height, 0);

}

- (void)beginRefreshWithTarget:(id)target refreshAction:(SEL)action
{
    [super beginRefreshWithTarget:target refreshAction:action];
}


- (void)endRefreshing
{
    [super endRefreshing];
    
    self.isFilled = (self.scrollView.contentSize.height)-(self.scrollView.bounds.size.height - self.scrollView.contentInset.top - self.scrollView.contentInset.bottom) > 0 ? YES : NO;
    
    if (!self.isFilled)
    {
        self.hidden = YES;
    }
    else
    {
        self.hidden = NO;
    }
}

/*
    思路分析：
    对于上拉刷新需要做两层判断。
    1、是否正在拖拽  self.scrollView.dragging 当正在拖拽的时候怎么做，没有正在拖拽的时候怎么做。
    2、当前显示的有效的cell是否占满了整屏。判断条件:
        self.scrollView.contentSize.height >= self.scrollView.bounds.size.height
    3、最外层应该是对2的判断。
    4、然后再在里面对y 和 criticalY 进行判断。
 */


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (![keyPath isEqualToString:kObserveKey] || self.refreshState == FSRefreshStateIsRefreshing)
    {
        return;
    }
    
    if (!self.scrollView.isDragging && !self.scrollView.decelerating)
    {
        self.isFilled = (self.scrollView.contentSize.height)-(self.scrollView.bounds.size.height - self.scrollView.contentInset.top - self.scrollView.contentInset.bottom) > 0 ? YES : NO;
    }
    
    if (!self.isFilled) // 非全屏
    {
        self.hidden = YES;
    }
    else  // 全屏
    {
        self.hidden = NO;
    }
    
    CGFloat y = [change[@"new"] CGPointValue].y + self.scrollView.contentInset.top;;
    
    if (y <= 0) return;
    
//    CGFloat criticalY = self.scrollView.contentSize.height - self.scrollView.bounds.size.height;
    
//    CGFloat criticalY = self.scrollView.contentSize.height - self.scrollView.bounds.size.height + self.bounds.size.height + self.scrollView.contentInset.bottom;
    
//    CGFloat criticalY = -(self.bounds.size.height + self.scrollView.contentInset.top);
    
//    NSLog(@"Y = %lf %lf",y,criticalY);
    
    if (!self.isFilled)
    {
        self.hidden = NO;
        
        if (self.scrollView.isDragging)
        {
            if (y >= 30)
            {
                if (self.refreshState == FSRefreshStateNormal)
                {
                    [self setRefreshState:FSRefreshStateWillRefresh];
                    return;
                }
            }
            else
            {
                [self setRefreshState:FSRefreshStateNormal];
            }
        }
        else
        {
            if (self.refreshState == FSRefreshStateWillRefresh)
            {
                self.refreshState = FSRefreshStateIsRefreshing;
            }
        }
        
    }
    else
    {
        y -= self.scrollView.contentInset.top;
        
            CGFloat criticalY = self.scrollView.contentSize.height - self.scrollView.bounds.size.height + self.bounds.size.height;
        
        //    CGFloat criticalY = self.scrollView.contentSize.height - self.scrollView.bounds.size.height + self.bounds.size.height + self.scrollView.contentInset.bottom;
        
        //    CGFloat criticalY = -(self.bounds.size.height + self.scrollView.contentInset.top);
        
//            NSLog(@"Y = %lf %lf",y,criticalY);
        
        if (self.scrollView.isDragging)
        {
            if (y >= criticalY && self.refreshState == FSRefreshStateNormal)
            {
                [self setRefreshState:FSRefreshStateWillRefresh];
            }
            else if (y < criticalY)
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
    
    if (self.scrollView.contentSize.height != self.scrollViewOriginContentHeight)
    {
        [self layoutSubviews];
    }
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5 + self.scrollView.contentSize.height);
}


@end
