//
//  AKProgressView.m
//  
//
//  Created by Alexander Kharevich.
//  Copyright (c) 2014 Alexander Kharevich. All rights reserved.
//

#import "AKProgressView.h"


#define kProgressAnimationDuration  0.1f

@interface AKProgressView ()

@property (nonatomic, strong) UIImageView *trackImageView;
@property (nonatomic, strong) UIImageView *progressImageView;
@property (nonatomic, strong) NSLayoutConstraint * progressWidthConstraint;

@end


@implementation AKProgressView

@dynamic trackImage;
@dynamic progressImage;


-(void)dealloc
{
   
}

#pragma mark - NSObject



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupProgressView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setupProgressView];
    }
    return self;
}


#pragma mark - UIProgressView
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self setProgress:_progress];
}

-(void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    _progress = MIN(1.0f,MAX(0.0f,progress));  // progress value should be within 0..1;
    
    CGFloat animationDuration = animated ? kProgressAnimationDuration : 0.0f;
    
    CGFloat width = self.bounds.size.width * _progress;

    [UIView animateWithDuration:animationDuration animations:^{
        [self.progressWidthConstraint setConstant:width];
        [self layoutIfNeeded];
        
    }];
}


-(void)setProgress:(CGFloat)progress
{
    [self setProgress:progress animated:NO];
}


- (void)setProgressImage:(UIImage *)progressImage
{
    self.progressImageView.image = progressImage;
    
}

- (void)setTrackImage:(UIImage *)trackImage
{
    self.trackImageView.image = trackImage;
}


#pragma mark - private

- (void)setupProgressView
{
    UIImageView * trackImageView = [[UIImageView alloc]init];
    trackImageView.backgroundColor = [UIColor clearColor];
    trackImageView.contentMode = UIViewContentModeScaleToFill;
    trackImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.trackImageView = trackImageView;
    
    [self addSubview:self.trackImageView];
    
    
    
    NSArray * trackHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|[_trackImageView]|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:NSDictionaryOfVariableBindings(_trackImageView)];
    
    
    
    NSArray * trackVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_trackImageView]|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:NSDictionaryOfVariableBindings(_trackImageView)];
    
    [self addConstraints:trackHConstraints];
    [self addConstraints:trackVConstraints];
    
    
    UIImageView * progressImageView = [[UIImageView alloc]init];
    
    progressImageView.backgroundColor = [UIColor clearColor];
    progressImageView.contentMode = UIViewContentModeScaleToFill;
    progressImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.progressImageView = progressImageView;
    
    [self addSubview:self.progressImageView];
    
    NSArray * progressHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|[_progressImageView]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:NSDictionaryOfVariableBindings(_progressImageView)];
    
    NSArray * progressVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_progressImageView]|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:NSDictionaryOfVariableBindings(_progressImageView)];

    self.progressWidthConstraint = [NSLayoutConstraint constraintWithItem:_progressImageView
                                                               attribute:NSLayoutAttributeWidth
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:NSLayoutAttributeWidth
                                                              multiplier:1.0f
                                                                constant:0.0f];
    
    [self addConstraints:progressHConstraints];
    [self addConstraints:progressVConstraints];
    [self addConstraint:self.progressWidthConstraint];
}

@end
