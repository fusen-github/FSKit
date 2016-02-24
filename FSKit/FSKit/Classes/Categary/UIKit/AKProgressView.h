//
//  AKProgressView.h
//
//
//  Created by Alexander Kharevich.
//  Copyright (c) 2014 Alexander Kharevich. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AKProgressView : UIView

@property(nonatomic,assign) UIImage * progressImage;
@property(nonatomic,assign) UIImage * trackImage;
@property(nonatomic,assign) CGFloat progress;

-(void)setProgress:(CGFloat)progress animated:(BOOL)animated;

@end