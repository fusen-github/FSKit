//
//  UIView+Hud.m
//  BaseLib
//
//  Created by Nigel Chou on 16/3/14.
//  Copyright (c) 2016年 BeautyFuture. All rights reserved.
//

#import "UIView+Hud.h"
#import "objc/runtime.h"

@interface NCKHudView : UIView

@property(nonatomic) UIEdgeInsets insets;

@property(nonatomic,strong) UILabel *label;

@property(nonatomic,strong) UIActivityIndicatorView *indicatorView;

@property(nonatomic,strong) UIImageView *imageView;

@property(nonatomic) NCHudState hudeState;

@property(nonatomic) int padding;

@property(nonatomic,strong) NSDictionary *infoDict;

@property(nonatomic,copy) void (^block)(NCHudState state);

- (void)adjustFrame;

- (void)setInfoText:(NSString *)text hudState:(NCHudState)state;

@end

@implementation UIView (Hud)

static char nckHudViewKey;

- (NCKHudView *)associateHudView
{
    NCKHudView *hud = objc_getAssociatedObject(self, &nckHudViewKey);
    
    if (!hud) {
        
        hud = [[NCKHudView alloc] initWithFrame:self.bounds];
        
        objc_setAssociatedObject(self, &nckHudViewKey, hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [self addSubview:hud];
    }
    
    return hud;
}

- (void)nck_setHudState:(NCHudState)state
{
    [self nck_setHudState:state hudImage:nil];
}

- (void)nck_setHudState:(NCHudState)state hudImage:(UIImage *)image
{
    NCKHudView *hud = [self associateHudView];
    
    if (state == NCHudStateRemove) {
        
        [hud removeFromSuperview];
        
        objc_setAssociatedObject(self, &nckHudViewKey, nil, OBJC_ASSOCIATION_ASSIGN);
        
        return;
    }
    
    hud.imageView.image = image;
    
    hud.hudeState = state;
}


- (void)nck_setHudInsets:(UIEdgeInsets)insets
{
    NCKHudView *hud = [self associateHudView];
    
    if(hud) {
        
        hud.insets = insets;
        
        [hud adjustFrame];
    }
}

- (void)nck_setOnTapBlock:(void (^)(NCHudState state))block
{
    NCKHudView *hud = [self associateHudView];
    
    if(hud) {

        hud.block = block;
    }
}

- (void)nck_setInfoText:(NSString *)text hudState:(NCHudState)state
{
    NCKHudView *hud = [self associateHudView];
    
    if(hud) {
        
        [hud setInfoText:text hudState:state];
    }
}

- (void)nck_setFont:(UIFont *)font
{
    NCKHudView *hud = [self associateHudView];

    if (hud) {
        
        hud.label.font = font;
        
        [hud adjustFrame];
    }
}

- (void)nck_setLabelTextColor:(UIColor *)color
{
    NCKHudView *hud = [self associateHudView];
    
    if (hud) {
        
        hud.label.textColor = color;
    }
}

- (void)nck_setLabelShadowColor:(UIColor *)color
{
    NCKHudView *hud = [self associateHudView];
    
    if (hud) {
        
        hud.label.shadowColor = color;
    }
}

- (void)nck_setPaddingBetweenImageAndText:(int)padding
{
    NCKHudView *hud = [self associateHudView];
    
    if (hud) {
        
        hud.padding = padding;
        
        [hud adjustFrame];
    }
}
@end

@implementation NCKHudView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        
        self.insets = UIEdgeInsetsZero;
        
        self.padding = 20;
        
        [self addSubview:self.imageView];
        
        [self addSubview:self.indicatorView];
        
        [self addSubview:self.label];
        
        UITapGestureRecognizer *tap =
            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
        
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)handleTap
{
    if (self.block
        && (self.hudeState == NCHudStateNothing || self.hudeState == NCHudStateErr)) {
        
        self.block(self.hudeState);
    }
}

- (void)setHudeState:(NCHudState)hudeState
{
    _hudeState = hudeState;
    
    [self adjustFrame];
}

- (void)adjustFrame
{
    CGRect rect = self.superview.bounds;
    
    rect.origin.x = self.insets.left;
    
    rect.origin.y = self.insets.top;
    
    rect.size.width -= (self.insets.left + self.insets.right);
    
    rect.size.height -= (self.insets.top + self.insets.bottom);
    
    self.frame = rect;
    
    int h = _indicatorView.frame.size.height;
    
    if (_imageView.image) {
        
        h = _imageView.image.size.height + self.padding;
    }
    
    int y = (rect.size.height - h) / 2;
    
    int labelY = y;
    
    if (_imageView.image) {
        
        _imageView.frame = CGRectMake((rect.size.width - _imageView.image.size.width) / 2,
                                      y,
                                      _imageView.image.size.width,
                                      _imageView.image.size.height);
        
        labelY = CGRectGetMaxY(_imageView.frame) + 20;
    }
    
    _label.text = [self.infoDict objectForKey:@(self.hudeState)];
    
    [_label sizeToFit];
    
    int x = (rect.size.width - _label.frame.size.width - 10) / 2;
    
    if (self.hudeState == NCHudStateLoading) {
        
        x = (rect.size.width - _indicatorView.frame.size.width - _label.frame.size.width) / 2;
        
        [_indicatorView startAnimating];
        
        rect = _indicatorView.frame;
        
        rect.origin = CGPointMake(x, labelY);
        
        _indicatorView.frame = rect;
        
        x = CGRectGetMaxX(_indicatorView.frame) + 10;
    }
    else {
        
        [_indicatorView stopAnimating];
    }
    
    rect = _label.frame;
    
    rect.size.height = _indicatorView.frame.size.height;
    
    rect.origin = CGPointMake(x, labelY);
    
    _label.frame = rect;
}

- (UIActivityIndicatorView *)indicatorView
{
    if (_indicatorView) {
        
        return _indicatorView;
    }
    
    _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:2];
    
    return _indicatorView;
}

- (UIImageView *)imageView
{
    if (_imageView) {
        
        return _imageView;
    }
    
    _imageView = [[UIImageView alloc] init];
    
    return _imageView;
}

- (UILabel *)label
{
    if (_label) {
        
        return _label;
    }
    
    _label = [[UILabel alloc] init];
    
    _label.shadowColor = [UIColor whiteColor];
   
    _label.shadowOffset = CGSizeMake(0, 1);
    
    _label.font = [UIFont systemFontOfSize:13];
    
    _label.textColor = [UIColor grayColor];
    
    return _label;
}

- (NSDictionary *)infoDict
{
    if (_infoDict) {
        
        return _infoDict;
    }
    
    _infoDict = @{@(NCHudStateLoading):@"正在加载...",
                  @(NCHudStateNothing):@"加载的数据为空！",
                  @(NCHudStateErr):@"加载失败，点击重新载入！"};
    
    return _infoDict;
}

- (void)setInfoText:(NSString *)text hudState:(NCHudState)state
{
    NSString *str = text ? @"" : text;
   
    NSMutableDictionary *dict = [self.infoDict mutableCopy];
    
    [dict setObject:str forKey:@(state)];
    
    _infoDict = dict;
    
    [self adjustFrame];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview) {
        
        [self.superview addObserver:self
                         forKeyPath:@"frame"
                            options:NSKeyValueObservingOptionNew context:nil];
    }
    else {
        
        [self.superview removeObserver:self forKeyPath:@"frame"];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context
{
    [self adjustFrame];
}
@end