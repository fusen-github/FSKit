//
//  FSRefreshHeader.m
//  FSSimpleRefresh
//
//  Created by 四维图新 on 16/3/15.
//  Copyright © 2016年 四维图新. All rights reserved.
//

#import "FSRefreshHeader.h"

#define kRefreshHeaderTitlePullDown @"下拉可以刷新"

#define kRefreshHeaderRelease @"释放立即刷新"

#define kRefreshHeaderRefreshing @"正在刷新..."

#define kRefreshHeaderHeight 60

@interface FSRefreshHeader ()

@property (nonatomic, weak, readonly) UIScrollView *scrollView;

@property (nonatomic, weak) UIView *headView;

@property (nonatomic, weak) UILabel *infoLabel;

@property (nonatomic, weak) UIActivityIndicatorView *activity;

@property (nonatomic, assign) BOOL hasNavBar;

@property (nonatomic, weak) UIImageView *imageV;

@property (nonatomic, assign) BOOL isRefreshing;

@property (nonatomic, assign) BOOL willRefresh;

@property (nonatomic, copy) FSRefreshHeaderBlock refreshBlock;

@property (nonatomic, assign) UIEdgeInsets originContenInset;

@property (nonatomic, assign) UIEdgeInsets inset1;

@property (nonatomic, assign) UIEdgeInsets inset2;

//@property (nonatomic, assign) UIEdgeInsets addContentInset;

@end

@implementation FSRefreshHeader

+ (instancetype)headerWithScrollView:(UIScrollView *)scrollView
{
    return [[self alloc] initWithScrollView:scrollView];
}

- (instancetype)initWithScrollView:(UIScrollView *)scrollView
{
    if (self = [super init])
    {
        _scrollView = scrollView;
        
        [self setupHeaderViewWithScrollView:scrollView];
    }
    
    return self;
}

- (void)setupHeaderViewWithScrollView:(UIScrollView *)scrollView
{
    UIView *headView = [[UIView alloc] init];
    
    headView.backgroundColor = [UIColor redColor];
    
    self.headView = headView;
    
    headView.frame = CGRectMake(0, -kRefreshHeaderHeight, self.scrollView.bounds.size.width, kRefreshHeaderHeight);
    
    [scrollView addSubview:headView];
    
    
    UILabel *infoLabel = [[UILabel alloc] init];
    
    infoLabel.font = [UIFont systemFontOfSize:14];
    
    infoLabel.textColor = [UIColor grayColor];
    
    infoLabel.textAlignment = NSTextAlignmentCenter;
    
    self.infoLabel = infoLabel;
    
    infoLabel.text = kRefreshHeaderTitlePullDown;
    
    [infoLabel sizeToFit];
    
    [headView addSubview:infoLabel];
    
    
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] init];
    
    self.activity = activity;
    
    activity.hidden = YES;
    
    activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
    activity.hidesWhenStopped = YES;
    
    [activity sizeToFit];
    
    [headView addSubview:activity];
    
    
    UIImage *image = [UIImage imageNamed:@"down"];
    
    UIImageView *imageV = [[UIImageView alloc] init];
    
    self.imageV = imageV;
    
    imageV.image = image;
    
    [headView addSubview:imageV];
    
    
    CGSize headSize = headView.bounds.size;
    
    CGFloat activeX = (headSize.width - infoLabel.bounds.size.width - 20 - activity.bounds.size.width) * 0.5;
    
    CGFloat activeY = (headSize.height - activity.bounds.size.height) * 0.5;
    
    activity.frame = CGRectMake(activeX, activeY, activity.bounds.size.width, activity.bounds.size.height);
    
    
    CGFloat infoLabelX = CGRectGetMaxX(activity.frame) + 20;
    
    CGFloat infoLableY = (headSize.height - infoLabel.bounds.size.height) * 0.5;
    
    infoLabel.frame = CGRectMake(infoLabelX, infoLableY, infoLabel.bounds.size.width, infoLabel.bounds.size.height);
    
    
    CGFloat imageX = (headSize.width - infoLabel.bounds.size.width - 20 - image.size.width) * 0.5;
    
    CGFloat imageY = (headSize.height - image.size.height) * 0.5;
    
    imageV.frame = CGRectMake(imageX, imageY, image.size.width, image.size.height);
    
    [self.scrollView addObserver:self
                 forKeyPath:@"contentOffset"
                    options:NSKeyValueObservingOptionNew context:nil];
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (![keyPath isEqualToString:@"contentOffset"] ||
        self.scrollView.bounds.size.height == 0)
    {
        return;
    }
    
    if (self.scrollView.isDragging)
    {
        CGFloat offsetY = [[change objectForKey:@"new"] CGPointValue].y;
        
        // 临界的Y值
        CGFloat criticalY = -(self.headView.bounds.size.height + self.scrollView.contentInset.top);
        
//        NSLog(@"%lf",offsetY - criticalY);
        
        if (!self.isRefreshing)
        {
            if (offsetY < criticalY)
            {
                self.infoLabel.text = kRefreshHeaderRelease;
                
                [self.infoLabel sizeToFit];
                
                [UIView animateWithDuration:0.25 animations:^{
                    self.imageV.transform = CGAffineTransformMakeRotation(M_PI);
                }];
                
                self.willRefresh = YES;
            }
            else
            {
                if (self.willRefresh == YES)
                {
                    self.infoLabel.text = kRefreshHeaderTitlePullDown;
                    
                    [self.infoLabel sizeToFit];
                    
                    [UIView animateWithDuration:0.25 animations:^{
                        self.imageV.transform = CGAffineTransformIdentity;
                    }];
                    
                    self.willRefresh = NO;
                }
            }
        }
    }
    else
    {
        if ([self.infoLabel.text isEqualToString:kRefreshHeaderRelease])
        {
            [self beginRefresh];
        }
    }
}


- (void)beginRefreshWithHeaderBlock:(FSRefreshHeaderBlock)block
{
    self.refreshBlock = block;
}

- (void)beginRefreshWhenViewWillAppear
{
    self.scrollView.contentOffset = CGPointMake(0, -(kRefreshHeaderHeight + self.scrollView.contentInset.top));
    
    [self beginRefresh];
}


- (void)beginRefresh
{
    if (!self.isRefreshing)
    {
        self.infoLabel.text = kRefreshHeaderRefreshing;
        
        self.isRefreshing = YES;
        
        self.imageV.hidden = YES;
        
        self.activity.hidden = NO;
        
        [self.activity startAnimating];
        
        
        self.originContenInset = self.scrollView.contentInset;
        
        self.scrollView.contentInset = UIEdgeInsetsMake(self.originContenInset.top + kRefreshHeaderHeight, self.originContenInset.left, self.originContenInset.bottom, self.originContenInset.right);
        
        self.inset1 = self.scrollView.contentInset;
        
        if (self.refreshBlock)
        {
            self.refreshBlock();
        }
    }
}


- (void)endHeaderRefreshing
{
    if (self.isRefreshing)
    {
        self.isRefreshing = NO;
        
        self.inset2 = self.scrollView.contentInset;
        
        CGFloat difTop = self.inset2.top - self.inset1.top;
        
        UIEdgeInsets inset = self.originContenInset;
        
        inset.top += difTop;
        
        self.originContenInset = inset;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.scrollView.contentInset = self.originContenInset;
            
        } completion:^(BOOL finished) {
            
            self.infoLabel.text = kRefreshHeaderTitlePullDown;
            
            [self.activity stopAnimating];
            
            self.activity.hidden = YES;
            
            self.imageV.hidden = NO;
            
            self.imageV.transform = CGAffineTransformIdentity;
        }];
    }
}


- (void)dealloc
{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
