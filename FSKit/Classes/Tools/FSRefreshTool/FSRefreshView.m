//
//  FSRefreshView.m
//  SDRefreshView
//
//  Created by 四维图新 on 16/3/14.
//  Copyright (c) 2016年 GSD. All rights reserved.
//

#import "FSRefreshView.h"

#define kActivityLeftMargin 50

#define kRefreshViewDefaultHeight 60

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@interface FSRefreshView ()

@property (nonatomic, weak) UIImageView *arrowView;

@property (nonatomic, weak) UILabel *infoLabel;

@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, strong) id target;

@property (nonatomic) SEL refreshAction;

@property (nonatomic, assign) UIEdgeInsets originalContentInset;

@property (nonatomic, strong) NSDate *lastRefreshDate;

@property (nonatomic, weak, readonly) UIActivityIndicatorView *activity;

@property (nonatomic, assign) UIEdgeInsets inset1;

@property (nonatomic, assign) UIEdgeInsets inset2;

@end

@implementation FSRefreshView

+ (instancetype)refreshViewWithScrollView:(UIScrollView *)scrollView
{
    return [[self alloc] initWithScrollView:scrollView];
}

- (instancetype)initWithScrollView:(UIScrollView *)scrollView
{
    if (self = [super init])
    {
        _scrollView = scrollView;
        
        [_scrollView addSubview:self];
        
        [_scrollView addObserver:self
                      forKeyPath:kObserveKey options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupSubviews];
    }
    return self;
}


- (void)setupSubviews
{
    // 1、创建刷新指示器
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] init];
    
    _activity = activity;
    
    [activity startAnimating];
    
    [activity setHidesWhenStopped:YES];
    
    activity.hidden = YES;
    
    activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
    [self addSubview:activity];
    
    
    // 2、创建箭头
    UIImageView *imageV = [[UIImageView alloc] init];
    
    imageV.image = [UIImage imageNamed:@"sdRefeshView_arrow"];
    
    self.arrowView = imageV;
    
    [self addSubview:imageV];
    
    
    // 3、创建提示label
    UILabel *infoLabel = [[UILabel alloc] init];
    
    self.infoLabel = infoLabel;
    
    infoLabel.backgroundColor = [UIColor clearColor];
    
    infoLabel.font = [UIFont systemFontOfSize:14];
    
    infoLabel.textAlignment = NSTextAlignmentCenter;
    
    infoLabel.textColor = [UIColor blackColor];
    
    [self addSubview:infoLabel];
    
    
    // 4、创建时间label
    UILabel *timeLabel = [[UILabel alloc] init];
    
    self.timeLabel = timeLabel;
    
    timeLabel.textAlignment = NSTextAlignmentCenter;
    
    timeLabel.font = [UIFont systemFontOfSize:14];
    
    timeLabel.textColor = [UIColor blackColor];
    
    timeLabel.backgroundColor = [UIColor clearColor];
    
    [self addSubview:timeLabel];
}



- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
//    NSLog(@"3-%@",NSStringFromUIEdgeInsets(self.scrollView.contentInset));
    
    self.frame = CGRectMake(0, 0, self.scrollView.bounds.size.width, kRefreshViewDefaultHeight);
    
    if (!newSuperview)
    {
        [self removeObserver:self forKeyPath:kObserveKey];
    }
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
}

- (void)beginRefreshWithTarget:(id)target refreshAction:(SEL)action
{
    self.target = target;
    
    self.refreshAction = action;
}


- (void)setRefreshState:(FSRefreshState)refreshState
{
    _refreshState = refreshState;
    
    switch (refreshState)
    {
        case FSRefreshStateNormal:
            
            [self refreshStateNormal];
            break;
            
        case FSRefreshStateWillRefresh:
            
            [self refreshStateWillRefresh];
            break;
        
        case FSRefreshStateIsRefreshing:
            
            [self refreshStateIsRefreshing];
            break;
        default:
            break;
    }
}

- (void)refreshStateNormal
{
//    NSLog(@"5-%@",NSStringFromUIEdgeInsets(self.scrollView.contentInset));
    _isRefreshing = NO;
    
    [self.activity stopAnimating];
    
    [self.activity setHidden:YES];

    self.arrowView.hidden = NO;

    [UIView animateWithDuration:0.25 animations:^{
       
        self.arrowView.transform = CGAffineTransformMakeRotation(self.arrowNormalRadian);
        
    } completion:^(BOOL finished) {
        
    }];
    
    self.infoLabel.text = self.normalInfoText;
    
    [self.infoLabel sizeToFit];
    
    if (self.refreshViewType == FSRefreshViewTypeHeader)
    {
        self.timeLabel.text = [NSString stringWithFormat:@"最后刷新 %@",[self getLastRefreshTime]];
    }
    else if (self.refreshViewType == FSRefreshViewTypeFooder)
    {
        self.timeLabel.text = [NSString stringWithFormat:@"最后加载 %@",[self getLastRefreshTime]];
    }
}


- (void)refreshStateWillRefresh
{
//    NSLog(@"6-%@",NSStringFromUIEdgeInsets(self.scrollView.contentInset));
    
    _isRefreshing = NO;
    
    self.infoLabel.text = self.willRefreshInfoText;
    
    [self.infoLabel sizeToFit];
    
    [UIView animateWithDuration:0.25 animations:^{
       
        self.arrowView.transform = CGAffineTransformMakeRotation(self.arrowWillRefreshRadian);
        
    } completion:^(BOOL finished) {
        
    }];
}


- (void)refreshStateIsRefreshing
{
//    NSLog(@"7-%@",NSStringFromUIEdgeInsets(self.scrollView.contentInset));
    
    self.originalContentInset = self.scrollView.contentInset;
    
    self.scrollView.contentInset = [self getNewContentInsetWithAddInset:self.addContentInset];
    
//    NSLog(@"8-%@",NSStringFromUIEdgeInsets(self.scrollView.contentInset));
    
    self.inset1 = self.scrollView.contentInset;
    
    self.arrowView.hidden = YES;
    
    self.activity.hidden = NO;
    
    [self.activity startAnimating];
    
    _isRefreshing = YES;
    
    self.lastRefreshDate = [NSDate date];
    
    [self saveDate];
    
    self.infoLabel.text = self.isRefreshingInfoText;
    
    [self.infoLabel sizeToFit];
    
    if (self.beginRefreshBlock)
    {
        self.beginRefreshBlock();
    }
    else if (self.target)
    {
        if ([self.target respondsToSelector:self.refreshAction])
        {
            //  直接使用该方法，会有“可能出现内存泄露”的警告。可是使用下面的宏方法。
//            [self.target performSelector:self.refreshAction];
            
            SuppressPerformSelectorLeakWarning([self.target performSelector:self.refreshAction]);
        }
    }
}


- (void)endRefreshing
{
    self.inset2 = self.scrollView.contentInset;
    
    CGFloat diffTop = self.inset2.top - self.inset1.top;
    
    UIEdgeInsets inset = self.originalContentInset;
    
    inset.top += diffTop;
    
    self.originalContentInset = inset;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.scrollView.contentInset = self.originalContentInset;
        
    } completion:^(BOOL finished) {
        
        self.refreshState = FSRefreshStateNormal;
        
    }];
}


- (UIEdgeInsets)getNewContentInsetWithAddInset:(UIEdgeInsets)inset
{
    CGFloat top = self.scrollView.contentInset.top + inset.top;
    
    CGFloat left = self.scrollView.contentInset.left + inset.left;
    
    CGFloat bottom = self.scrollView.contentInset.bottom + inset.bottom;
    
    CGFloat right = self.scrollView.contentInset.right + inset.right;
    
    return UIEdgeInsetsMake(top, left, bottom, right);
}

- (void)saveDate
{
    NSString *headerKey = nil;
    
    NSString *footerKey = nil;
    
    if (self.refreshViewType == FSRefreshViewTypeHeader)
    {
        headerKey = @"header";
    }
    else if (self.refreshViewType == FSRefreshViewTypeFooder)
    {
        footerKey = @"footer";
    }
    
    NSString *key = headerKey ? headerKey : footerKey;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:self.lastRefreshDate forKey:key];
}


- (NSDate *)getLastRefreshDate
{
    NSString *headerKey = nil;
    
    NSString *footerKey = nil;
    
    if (self.refreshViewType == FSRefreshViewTypeHeader)
    {
        headerKey = @"header";
    }
    else if (self.refreshViewType == FSRefreshViewTypeFooder)
    {
        footerKey = @"footer";
    }
    
    NSString *key = headerKey ? headerKey : footerKey;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (self.lastRefreshDate)
    {
        [defaults setObject:self.lastRefreshDate forKey:key];
        
        return self.lastRefreshDate;
    }
    
    if ([defaults objectForKey:key])
    {
        self.lastRefreshDate = [defaults objectForKey:key];
        
        return self.lastRefreshDate;
    }
    
    [defaults setObject:[NSDate date] forKey:key];
    
    self.lastRefreshDate = [NSDate date];
    
    return [NSDate date];
}


- (NSString *)getLastRefreshTime
{
    NSDate *date = [self getLastRefreshDate];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    if (![self isThisYearWithDate:date])
    {
        format.dateFormat = @"yyyy年MM月";
        
        return [format stringFromDate:date];
    }
    else
    {
        if (![self isYesterdayWithDate:date] && ![self isTodayWithDate:date]) // 前天之前
        {
            format.dateFormat = @"MM月dd日";
            
            return [format stringFromDate:date];
        }
        else if ([self isYesterdayWithDate:date] && ![self isTodayWithDate:date]) // 就是昨天
        {
            format.dateFormat = @"HH:mm";
            
            NSString *str = [format stringFromDate:date];
            
            return [NSString stringWithFormat:@"昨天 %@",str];
        }
        else if ([self isTodayWithDate:date])
        {
            format.dateFormat = @"HH:mm";
            
            NSString *str = [format stringFromDate:date];
            
            return [NSString stringWithFormat:@"今天 %@",str];
        }
    }
    
    return nil;
}

- (BOOL)isTodayWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:date];
    return
    (selfCmps.year == nowCmps.year) &&
    (selfCmps.month == nowCmps.month) &&
    (selfCmps.day == nowCmps.day);
}

- (BOOL)isYesterdayWithDate:(NSDate *)date
{
    // 2014-05-01
    NSDate *nowDate = [self formatDateWithDate:[NSDate date]];
    
    // 2014-04-30
    NSDate *selfDate = [self formatDateWithDate:date];
    
    // 获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay
                                         fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.day == 1;
}


- (NSDate *)formatDateWithDate:(NSDate *)date
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *selfStr = [fmt stringFromDate:date];
    
    return [fmt dateFromString:selfStr];
}

- (BOOL)isThisYearWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:date];
    
    return nowCmps.year == selfCmps.year;
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.activity sizeToFit];
    
    self.activity.center = CGPointMake(kActivityLeftMargin, self.bounds.size.height * 0.5);
    
    [self.arrowView sizeToFit];
    
    self.arrowView.center = self.activity.center;
    
    [self.infoLabel sizeToFit];
    
    self.infoLabel.center = CGPointMake(self.bounds.size.width * 0.5, self.infoLabel.bounds.size.height * 0.5 + 10);
    
    [self.timeLabel sizeToFit];
    
    self.timeLabel.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height - self.timeLabel.bounds.size.height * 0.5 - 10);
}


@end
