//
//  FSRefreshFooter.m
//  FSSimpleRefresh
//
//  Created by 四维图新 on 16/3/15.
//  Copyright © 2016年 四维图新. All rights reserved.
//

#import "FSRefreshFooter.h"

#define kRefreshFooterTitlePullUp @"上拉可以加载更多"

#define kRefreshFooterRelease @"释放立即加载"

#define kRefreshFooterRefreshing @"正在加载..."

#define kRefreshFooterHeight 55

#define kObserveKey @"contentOffset"


@interface FSRefreshFooter ()

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, assign) UIEdgeInsets originContentInset;

@property (nonatomic, weak) UIView *footer;

@property (nonatomic, weak) UIImageView *imageV;

@property (nonatomic, weak) UIActivityIndicatorView *activity;

@property (nonatomic, weak) UILabel *infoLabel;

@property (nonatomic, assign) BOOL willLoadMore;

@property (nonatomic, copy) FSRefreshFooterBlock block;

@property (nonatomic, assign) BOOL isLoading;

@end

@implementation FSRefreshFooter

+ (instancetype)footerWithScrollView:(UIScrollView *)scrollView
{
    return [[self alloc] initWithScrollView:scrollView];
}

- (instancetype)initWithScrollView:(UIScrollView *)scrollView
{
    if (self = [super init])
    {
        self.scrollView = scrollView;
        
        [self setupFooterView];
    }
    return self;
}

- (void)setupFooterView
{
    UIView *footer = [[UIView alloc] init];
    
    self.footer = footer;
    
    footer.frame = CGRectMake(0, self.scrollView.contentSize.height, self.scrollView.bounds.size.width, kRefreshFooterHeight);
    
    footer.backgroundColor = [UIColor redColor];
    
    [self.scrollView addSubview:footer];
    
    
    UIImageView *imageV = [[UIImageView alloc] init];
    
    self.imageV = imageV;
    
    UIImage *image = [UIImage imageNamed:@"down"];
    
    imageV.image = image;
    
    [imageV sizeToFit];
    
    [footer addSubview:imageV];
    
    imageV.transform = CGAffineTransformMakeRotation(M_PI);
    
    
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] init];
    
    self.activity = activity;
    
    activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
    activity.hidden = YES;
    
    activity.hidesWhenStopped = YES;
    
    [activity sizeToFit];
    
    [footer addSubview:activity];
    
    
    UILabel *infoLabel = [[UILabel alloc] init];
    
    self.infoLabel = infoLabel;
    
    infoLabel.backgroundColor = [UIColor clearColor];
    
    infoLabel.font = [UIFont systemFontOfSize:14];
    
    infoLabel.textColor = [UIColor grayColor];
    
    infoLabel.textAlignment = NSTextAlignmentCenter;
    
    infoLabel.text = kRefreshFooterTitlePullUp;
    
    [infoLabel sizeToFit];
    
    [footer addSubview:infoLabel];
    
    
    CGSize footerSize = footer.bounds.size;
    
    CGFloat imageX = (footerSize.width - image.size.width - infoLabel.bounds.size.width - 20) * 0.5;
    
    CGFloat imageY = (footerSize.height - image.size.height) * 0.5;
    
    imageV.frame = (CGRect){{imageX,imageY},image.size};
    
    CGFloat activityX = (footerSize.width - activity.bounds.size.width - infoLabel.bounds.size.width - 20) * 0.5;
    
    CGFloat activityY = (footerSize.height - activity.bounds.size.height) * 0.5;
    
    activity.frame = (CGRect){{activityX,activityY},activity.bounds.size};
    
    CGFloat infoLabelX = CGRectGetMaxX(activity.frame) + 20;
    
    CGFloat infoLabelY = (footerSize.height - infoLabel.bounds.size.height) * 0.5;
    
    infoLabel.frame = (CGRect){{infoLabelX,infoLabelY},infoLabel.bounds.size};
    
    [self.scrollView addObserver:self
                      forKeyPath:kObserveKey
                         options:NSKeyValueObservingOptionNew context:nil];
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (![keyPath isEqualToString:kObserveKey] || self.scrollView.bounds.size.height == 0)
    {
        return;
    }
    
    CGFloat offsetY = [[change objectForKey:@"new"] CGPointValue].y;
    
//    CGFloat criticalY = -(self.footer.bounds.size.height + self.scrollView.contentInset.bottom);
    
    CGFloat criticalY = self.scrollView.contentSize.height - self.scrollView.bounds.size.height;
    
    if (self.scrollView.isDragging)
    {
        if (offsetY > criticalY + kRefreshFooterHeight)
        {
            self.infoLabel.text = kRefreshFooterRelease;
            
            [self.infoLabel sizeToFit];
            
            self.willLoadMore = YES;
            
            [UIView animateWithDuration:0.25 animations:^{
                self.imageV.transform = CGAffineTransformIdentity;
            }];
        }
        else
        {
            if (self.willLoadMore)
            {
                self.infoLabel.text = kRefreshFooterTitlePullUp;
                
                [self.infoLabel sizeToFit];
                
                self.willLoadMore = NO;
                
                [UIView animateWithDuration:0.25 animations:^{
                    self.imageV.transform = CGAffineTransformMakeRotation(M_PI);
                }];
            }
        }
    }
    else
    {
        if ([self.infoLabel.text isEqualToString:kRefreshFooterRelease])
        {
            [self beginRefresh];
        }
    }
    
}


- (void)beginRefreshWithFooterBlock:(FSRefreshFooterBlock)block
{
    self.block = block;
}

- (void)beginRefresh
{
    if (!self.isLoading)
    {
        self.isLoading = YES;
        
        self.infoLabel.text = kRefreshFooterRefreshing;
        
        self.willLoadMore = NO;
        
        self.imageV.hidden = YES;
        
        self.activity.hidden = NO;
        
        [self.activity startAnimating];
        
        self.originContentInset = self.scrollView.contentInset;
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.scrollView.contentInset = UIEdgeInsetsMake(self.originContentInset.top, self.originContentInset.left, self.originContentInset.bottom + kRefreshFooterHeight, self.originContentInset.right);
        }];
        
        if (self.block)
        {
            self.block();
        }
    }
}

- (void)endFooterRefreshing
{
    if (self.isLoading)
    {
        self.isLoading = NO;
        
        [UIView animateWithDuration:0.25 animations:^{
           
            self.scrollView.contentInset = self.originContentInset;
            
        } completion:^(BOOL finished) {
            
            self.infoLabel.text = kRefreshFooterTitlePullUp;
            
            [self.infoLabel sizeToFit];
            
            [self.activity stopAnimating];
            
            self.activity.hidden = YES;
            
            self.imageV.hidden = NO;
            
            self.imageV.transform = CGAffineTransformMakeRotation(M_PI);
            
        }];
    }
}


- (void)dealloc
{
    [self.scrollView removeObserver:self forKeyPath:kObserveKey];
}

@end
