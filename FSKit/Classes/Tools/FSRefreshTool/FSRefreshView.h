//
//  FSRefreshView.h
//  SDRefreshView
//
//  Created by 四维图新 on 16/3/14.
//  Copyright (c) 2016年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, FSRefreshState) {
    
    FSRefreshStateNormal,           // 正常状态
    FSRefreshStateWillRefresh,      // 即将刷新状态
    FSRefreshStateIsRefreshing      // 正在刷新状态
};

typedef NS_ENUM(NSInteger, FSRefreshViewType){

    FSRefreshViewTypeHeader,
    FSRefreshViewTypeFooder
};

typedef void(^FSBeginRefreshBlock)();

#define kObserveKey @"contentOffset"

@interface FSRefreshView : UIView

@property (nonatomic, copy) FSBeginRefreshBlock beginRefreshBlock;

@property (nonatomic, weak, readonly) UIScrollView *scrollView;
/**
 *  默认状态下 箭头需要旋转的弧度。
 */
@property (nonatomic, assign) CGFloat arrowNormalRadian;
/**
 *  一松手就要进入刷新状态时 箭头需要旋转的弧度
 */
@property (nonatomic, assign) CGFloat arrowWillRefreshRadian;

@property (nonatomic, strong) NSString *normalInfoText;

@property (nonatomic, strong) NSString *willRefreshInfoText;

@property (nonatomic, strong) NSString *isRefreshingInfoText;

@property (nonatomic, assign) FSRefreshState refreshState;

@property (nonatomic, assign) UIEdgeInsets addContentInset;

@property (nonatomic, assign) FSRefreshViewType refreshViewType;

@property (nonatomic, readonly) BOOL isRefreshing;


/**
 *  初始化生成一个refreshView
 *
 *  @param scrollView 外面传进来的需要刷新的scrollView
 *  @param isExist    是否有导航控制器
 *
 *  @return refreshView对象。
 */
- (instancetype)initWithScrollView:(UIScrollView *)scrollView;

+ (instancetype)refreshViewWithScrollView:(UIScrollView *)scrollView;

- (void)beginRefreshWithTarget:(id)target refreshAction:(SEL)action;

- (void)endRefreshing;



@end
