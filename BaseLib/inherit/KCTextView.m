//
//  KCTextView.m
//  BaseLib
//
//  Created by Kevin Chou on 15-2-11.
//  Copyright (c) 2015年 nowsilence. All rights reserved.
//

#import "KCTextView.h"
@interface KCTextView()

@property(nonatomic) BOOL showPlaceholder;

@end

@implementation KCTextView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.showPlaceholder = YES;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.showPlaceholder = YES;
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        self.showPlaceholder = YES;
    }
    
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
